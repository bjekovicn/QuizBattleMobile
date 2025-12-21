import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/injection.dart';
import '/gen/assets.gen.dart';
import '/ui/shared/state/app_bloc.dart';
import '/core/extensions/extensions.dart';
import '/ui/game_play/bloc/game_bloc.dart';
import '/ui/game_play/screens/game_screen.dart';
import '/ui/home/widgets/start_game_button.dart';
import '/ui/home/widgets/user_info_section.dart';
import '/data/game/domain/entities/game/game_type.dart';
import '/data/game/domain/repositories/game_repository.dart';
import '/ui/friend_battle_lobby/screens/friend_battle_lobby_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _setupFCMHandlers();
  }

  void _setupFCMHandlers() {
    // App opened from notification - terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _logFcmMessage('TERMINATED', message);
        _handleNotificationMessage(message);
      }
    });

    // App opened from notification - background state
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _logFcmMessage('BACKGROUND (tap)', message);
      _handleNotificationMessage(message);
    });

    // App in foreground - show dialog directly
    FirebaseMessaging.onMessage.listen((message) {
      _logFcmMessage('FOREGROUND', message);
      _handleForegroundNotification(message);
    });
  }

  void _handleNotificationMessage(RemoteMessage? message) {
    if (message == null) return;

    final type = message.data['type'];

    if (type == 'game_invite') {
      _showInviteDialog(
        inviteId: message.data['inviteId'] ?? '',
        roomId: message.data['roomId'] ?? '',
        hostName: message.data['hostName'] ?? 'Someone',
      );
    }
  }

  void _handleForegroundNotification(RemoteMessage message) {
    final type = message.data['type'];

    if (type == 'game_invite') {
      _showInviteDialog(
        inviteId: message.data['inviteId'] ?? '',
        roomId: message.data['roomId'] ?? '',
        hostName: message.data['hostName'] ?? 'Someone',
      );
    }
  }

  void _showInviteDialog({
    required String inviteId,
    required String roomId,
    required String hostName,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Game Challenge! 🎮'),
        content: Text('$hostName has challenged you to a QuizBattle!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _respondToInvite(inviteId, false);
            },
            child: const Text('Reject'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _respondToInvite(inviteId, true);
            },
            child: const Text('Accept'),
          ),
        ],
      ),
    );
  }

  Future<void> _respondToInvite(String inviteId, bool accept) async {
    log('[HomeScreen] Responding to invite: $inviteId, accept: $accept');

    final gameRepo = getIt<GameRepository>();

    // Show loading
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(accept ? 'Accepting invite...' : 'Rejecting invite...'),
          duration: const Duration(seconds: 1),
        ),
      );
    }

    final result = await gameRepo.respondToInvite(inviteId, accept);

    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${failure.message}')),
          );
        }
      },
      (roomId) {
        if (accept && roomId != null) {
          log('[HomeScreen] Invite accepted, navigating to lobby with roomId: $roomId');

          if (mounted) {
            // Navigate to FriendBattleLobbyScreen
            // SignalR will connect there
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FriendBattleLobbyScreen(
                  languageCode:
                      context.read<AppBloc>().state.locale.languageCode,
                  roomId: roomId, // Pass the roomId to join
                ),
              ),
            );
          }
        } else {
          log('[HomeScreen] Invite rejected');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invite rejected')),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const UserInfoSection(),
              const SizedBox(height: 40),
              StartGameButton(
                title: context.l.random_opponent,
                subtitle: context.l.random_opponent_duel,
                child: Image.asset(Assets.images.randomDuelLogo.path),
                onTap: () => _toRandomDuel(context),
              ),
              const SizedBox(height: 20),
              StartGameButton(
                title: context.l.challenge_friends,
                subtitle: context.l.challenge_friends_battle,
                child: Image.asset(Assets.images.friendsBattleLogo.path),
                onTap: () => _toFriendsBattle(context),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _toRandomDuel(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final languageCode = appBloc.state.locale.languageCode;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt<GameBloc>(),
          child: GameScreen(
            gameType: GameType.randomDuel.value,
            languageCode: languageCode,
          ),
        ),
      ),
    );
  }

  void _toFriendsBattle(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FriendBattleLobbyScreen(
          languageCode: context.read<AppBloc>().state.locale.languageCode,
        ),
      ),
    );
  }

  void _logFcmMessage(String source, RemoteMessage message) {
    log('📩 FCM MESSAGE [$source]');
    log('📌 messageId: ${message.messageId}');
    log('📌 from: ${message.from}');
    log('📌 sentTime: ${message.sentTime}');
    log('📌 data: ${message.data}');
    log('📌 notification: '
        'title=${message.notification?.title}, '
        'body=${message.notification?.body}');
    log('--------------------------------------');
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('📩 FCM MESSAGE [BACKGROUND ISOLATE]');
  debugPrint('📌 messageId: ${message.messageId}');
  debugPrint('📌 data: ${message.data}');
}
