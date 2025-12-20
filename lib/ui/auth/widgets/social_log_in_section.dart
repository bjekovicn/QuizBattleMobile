import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/injection.dart';
import '/ui/auth/state/auth_bloc.dart';
import '/ui/auth/state/auth_event.dart';
import '/core/di/app_config_module.dart';
import '/core/extensions/extensions.dart';

class SocialLogInSection extends StatefulWidget {
  const SocialLogInSection({super.key});

  @override
  State<SocialLogInSection> createState() => _SocialLogInSectionState();
}

class _SocialLogInSectionState extends State<SocialLogInSection> {
  @override
  void initState() {
    super.initState();

    final signIn = GoogleSignIn.instance;

    unawaited(
      signIn
          .initialize(
            clientId: getIt<AppConfig>().googleClientId,
            serverClientId: getIt<AppConfig>().googleServerClientId,
          )
          .then((_) => signIn.authenticationEvents
              .listen(_onGoogleAuthEvent)
              .onError(_onGoogleAuthError)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            context.l.log_in_info,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              try {
                await GoogleSignIn.instance.authenticate();
              } catch (e) {
                log('Google authenticate failed: $e');
              }
            },
            child: Text(context.l.google_sign_in),
          ),
        ],
      ),
    );
  }

  Future<void> _onGoogleAuthEvent(GoogleSignInAuthenticationEvent event) async {
    final authBloc = context.read<AuthBloc>();

    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn(user: final u) => u,
      GoogleSignInAuthenticationEventSignOut() => null,
    };

    if (user == null) return;

    final auth = user.authentication;
    final idToken = auth.idToken;

    if (idToken == null) {
      throw Exception('ID Token is null');
    }

    authBloc.add(RegisterUserEvent(idToken));
  }

  void _onGoogleAuthError(Object e) {
    log('Google Sign In error: $e');
  }
}
