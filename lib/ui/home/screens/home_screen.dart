import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/game_type.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

import '/injection.dart';
import '/gen/assets.gen.dart';
import '/ui/shared/state/app_bloc.dart';
import '/core/extensions/extensions.dart';
import '/ui/game_play/bloc/game_bloc.dart';
import '/ui/game_play/screens/game_screen.dart';
import '/ui/home/widgets/start_game_button.dart';
import '/ui/home/widgets/user_info_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   //App opened using notification created by SDK - terminated state
    //   FirebaseMessaging.instance
    //       .getInitialMessage()
    //       .then(_onNotificationMessageStartup);

    //   //App opened using notification created by SDK - background/foreground state
    //   FirebaseMessaging.onMessageOpenedApp
    //       .listen(_onNotificationMessageStartup);
    // });
    super.initState();
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
    final appBloc = context.read<AppBloc>();
    final languageCode = appBloc.state.locale.languageCode;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt<GameBloc>(),
          child: GameScreen(
            gameType: GameType.friendBattle.value,
            languageCode: languageCode,
          ),
        ),
      ),
    );
  }

  //void _onNotificationMessageStartup(RemoteMessage? message) {}
}
