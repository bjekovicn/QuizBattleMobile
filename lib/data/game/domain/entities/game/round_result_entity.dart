import 'player_round_result_entity.dart';
import 'player_score_entity.dart';

class RoundResultEntity {
  final int roundNumber;
  final int questionId;
  final String correctOption;
  final String correctAnswerText;
  final List<PlayerRoundResultEntity> playerResults;
  final List<PlayerScoreEntity> currentStandings;

  const RoundResultEntity({
    required this.roundNumber,
    required this.questionId,
    required this.correctOption,
    required this.correctAnswerText,
    required this.playerResults,
    required this.currentStandings,
  });

  /// Get the winner of this round (player with most points)
  PlayerRoundResultEntity? get roundWinner {
    if (playerResults.isEmpty) return null;
    return playerResults
        .reduce((a, b) => a.pointsAwarded > b.pointsAwarded ? a : b);
  }

  /// Get players who answered correctly
  List<PlayerRoundResultEntity> get correctPlayers =>
      playerResults.where((p) => p.isCorrect).toList();

  /// Get current leader
  PlayerScoreEntity? get currentLeader {
    if (currentStandings.isEmpty) return null;
    return currentStandings.first; // Already sorted by backend
  }

  RoundResultEntity copyWith({
    int? roundNumber,
    int? questionId,
    String? correctOption,
    String? correctAnswerText,
    List<PlayerRoundResultEntity>? playerResults,
    List<PlayerScoreEntity>? currentStandings,
  }) {
    return RoundResultEntity(
      roundNumber: roundNumber ?? this.roundNumber,
      questionId: questionId ?? this.questionId,
      correctOption: correctOption ?? this.correctOption,
      correctAnswerText: correctAnswerText ?? this.correctAnswerText,
      playerResults: playerResults ?? this.playerResults,
      currentStandings: currentStandings ?? this.currentStandings,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundResultEntity &&
          runtimeType == other.runtimeType &&
          roundNumber == other.roundNumber &&
          questionId == other.questionId;

  @override
  int get hashCode => roundNumber.hashCode ^ questionId.hashCode;

  @override
  String toString() {
    return 'RoundResultEntity(round: $roundNumber, correctOption: $correctOption)';
  }
}
