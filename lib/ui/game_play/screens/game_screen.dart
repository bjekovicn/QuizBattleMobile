import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/ui/game_play/bloc/game_bloc.dart';
import '/ui/game_play/bloc/game_events.dart';
import '/ui/game_play/bloc/game_states.dart';

class GameScreen extends StatefulWidget {
  final int gameType;
  final String languageCode;

  const GameScreen({
    super.key,
    required this.gameType,
    required this.languageCode,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameBloc>().add(ConnectEvent(
            pendingMatchmaking: JoinMatchmakingEvent(
              gameType: widget.gameType,
              languageCode: widget.languageCode,
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Battle')),
      body: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          // Show error dialog
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error!.message}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case GameStatus.idle:
              return const Center(child: Text('Connecting...'));

            case GameStatus.matchmaking:
              return _GameMatchmakingView();

            case GameStatus.lobby:
              return _GameLobyView(state: state);

            case GameStatus.starting:
              return _GameStartingView();

            case GameStatus.roundActive:
              return _RoundActiveView(state: state);

            case GameStatus.roundResult:
              return _RoundResultView(state: state);

            case GameStatus.finished:
              return _GameFinishedView(state: state);
          }
        },
      ),
    );
  }
}

class _GameMatchmakingView extends StatelessWidget {
  const _GameMatchmakingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          const Text('Finding opponent...'),
        ],
      ),
    );
  }
}

class _GameLobyView extends StatelessWidget {
  final GameState state;

  const _GameLobyView({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.room == null) {
      return const Center(child: Text('Loading room...'));
    }

    final room = state.room!;
    final players = room.players;
    final currentUserId = state.currentUserId;
    final isReady = currentUserId != null
        ? players.any((p) => p.userId == currentUserId && p.isReady)
        : false;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Waiting for players...', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 40),

          // Players display
          ...players.map((player) {
            final isCurrentUser = player.userId == currentUserId;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    player.displayName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          isCurrentUser ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (player.isReady)
                    const Icon(Icons.check_circle, color: Colors.green)
                  else
                    const Icon(Icons.circle_outlined),
                  if (!player.isConnected)
                    const Icon(Icons.signal_wifi_off, color: Colors.red),
                ],
              ),
            );
          }),

          const SizedBox(height: 40),

          // Ready button
          ElevatedButton(
            onPressed: () {
              context.read<GameBloc>().add(SetReadyEvent(!isReady));
            },
            child: Text(isReady ? 'Not Ready' : 'Ready'),
          ),
        ],
      ),
    );
  }
}

class _GameStartingView extends StatelessWidget {
  const _GameStartingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Game starting...', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class _RoundActiveView extends StatelessWidget {
  final GameState state;

  const _RoundActiveView({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.activeRound == null || state.room == null) {
      return const Center(child: Text('Loading round...'));
    }

    final round = state.activeRound!;
    final question = round.question;
    final hasAnswered = state.hasAnswered;
    final selectedAnswer = state.selectedAnswer;
    final players = state.room!.players;

    return Column(
      children: [
        // SCOREBOARD
        _PlayersScoreboard(
          players: players,
          currentUserId: state.currentUserId,
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Round ${round.currentRound} / ${round.totalRounds}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  question.text,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                _AnswerButton(
                  answer: 'A',
                  text: question.optionA,
                  isSelected: selectedAnswer == 'A',
                  isDisabled: hasAnswered,
                  onPressed: () => context
                      .read<GameBloc>()
                      .add(const SubmitAnswerEvent('A')),
                ),
                const SizedBox(height: 10),
                _AnswerButton(
                  answer: 'B',
                  text: question.optionB,
                  isSelected: selectedAnswer == 'B',
                  isDisabled: hasAnswered,
                  onPressed: () => context
                      .read<GameBloc>()
                      .add(const SubmitAnswerEvent('B')),
                ),
                const SizedBox(height: 10),
                _AnswerButton(
                  answer: 'C',
                  text: question.optionC,
                  isSelected: selectedAnswer == 'C',
                  isDisabled: hasAnswered,
                  onPressed: () => context
                      .read<GameBloc>()
                      .add(const SubmitAnswerEvent('C')),
                ),
                const SizedBox(height: 20),
                Text('Players answered: ${state.answeredPlayers.length}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String answer;
  final String text;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onPressed;

  const _AnswerButton({
    required this.answer,
    required this.text,
    required this.isSelected,
    required this.isDisabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.amber : Colors.grey[800],
          foregroundColor: isSelected ? Colors.black : Colors.white,
          disabledBackgroundColor: isSelected
              ? Colors.amber.withValues(alpha: 0.6)
              : Colors.grey[700],
          padding: const EdgeInsets.all(16),
        ),
        child: Text(
          '$answer) $text',
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _RoundResultView extends StatelessWidget {
  final GameState state;

  const _RoundResultView({required this.state});

  String _formatTime(int? ms) {
    if (ms == null) return '—';
    return '${(ms / 1000).toStringAsFixed(2)}s';
  }

  String _getAnswerText(String? answerGiven) {
    if (answerGiven == null) return 'No answer';

    // Map A/B/C to actual answer text from the question
    final question = state.activeRound?.question;
    if (question == null) return answerGiven;

    switch (answerGiven) {
      case 'A':
        return question.optionA;
      case 'B':
        return question.optionB;
      case 'C':
        return question.optionC;
      default:
        return answerGiven;
    }
  }

  Color _getAnswerColor(bool? isCorrect, String? answerGiven) {
    if (answerGiven == null) return Colors.grey; // No answer
    if (isCorrect == true) return Colors.green; // Correct
    return Colors.red; // Wrong
  }

  // Get player info from room.players to access photoUrl and colorHex
  dynamic _getPlayerInfo(int userId) {
    return state.room?.players.firstWhere(
      (p) => p.userId == userId,
    );
  }

  Color _safeColor(String? hex) {
    final value = int.tryParse(
      hex?.replaceFirst('#', '0xff') ?? '',
    );
    return Color(value ?? 0xff607D8B); // blueGrey fallback
  }

  @override
  Widget build(BuildContext context) {
    if (state.roundResult == null) {
      return const Center(child: Text('Loading results...'));
    }

    final result = state.roundResult!;
    final currentUserId = state.currentUserId;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Round Results',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'Correct answer: ${result.correctAnswerText}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: result.playerResults.length,
              itemBuilder: (context, index) {
                final pr = result.playerResults[index];
                final isMe = pr.userId == currentUserId;
                final answerColor =
                    _getAnswerColor(pr.isCorrect, pr.answerGiven);
                final playerInfo = _getPlayerInfo(pr.userId);

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: answerColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: answerColor,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      // PLAYER AVATAR
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: _safeColor(playerInfo?.colorHex),
                        backgroundImage: playerInfo?.photoUrl != null
                            ? NetworkImage(playerInfo!.photoUrl!)
                            : null,
                        child: playerInfo?.photoUrl == null
                            ? Text(
                                pr.displayName[0].toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),

                      // PLAYER INFO
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pr.displayName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    isMe ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _getAnswerText(pr.answerGiven),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Time: ${_formatTime(pr.responseTimeMs)}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // POINTS
                      Text(
                        '+${pr.pointsAwarded}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const CircularProgressIndicator(),
          const Text('Next round starting...'),
        ],
      ),
    );
  }
}

class _GameFinishedView extends StatelessWidget {
  final GameState state;

  const _GameFinishedView({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.gameResult == null) {
      return const Center(child: Text('Loading results...'));
    }

    final result = state.gameResult!;
    final currentUserId = state.currentUserId;
    final winner = result.finalStandings.first;
    final isWinner = winner.userId == currentUserId;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isWinner ? '🏆 YOU WON! 🏆' : 'Game Over',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Text(
            'Winner: ${winner.displayName}',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 40),

          const Text('Final Standings:', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),

          // Final standings
          ...result.finalStandings.asMap().entries.map((entry) {
            final index = entry.key;
            final standing = entry.value;
            final isCurrentUser = standing.userId == currentUserId;
            final medal = index == 0
                ? '🥇'
                : index == 1
                    ? '🥈'
                    : '🥉';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(medal, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 10),
                  Text(
                    standing.displayName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          isCurrentUser ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${standing.totalScore} pts',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }
}

class _PlayersScoreboard extends StatelessWidget {
  final List<dynamic> players;
  final int? currentUserId;

  const _PlayersScoreboard({
    required this.players,
    required this.currentUserId,
  });

  Color _safeColor(String? hex) {
    final value = int.tryParse(
      hex?.replaceFirst('#', '0xff') ?? '',
    );
    return Color(value ?? 0xff607D8B); // blueGrey fallback
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: players.map((player) {
          final isMe = player.userId == currentUserId;

          return Container(
            width: 88,
            height: 110,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isMe
                  ? Colors.amber.withValues(alpha: 0.15)
                  : Colors.grey[850],
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isMe ? Colors.amber : Colors.grey,
                width: isMe ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AVATAR
                CircleAvatar(
                  radius: 18,
                  backgroundColor: _safeColor(player.colorHex),
                  backgroundImage: player.photoUrl != null
                      ? NetworkImage(player.photoUrl!)
                      : null,
                  child: player.photoUrl == null
                      ? Text(
                          player.displayName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 2),

                // NAME
                FittedBox(
                  child: Text(
                    player.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isMe ? FontWeight.bold : FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 2),

                // CURRENT SCORE
                Text(
                  '${player.totalScore ?? 0}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
