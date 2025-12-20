import 'package:flutter/material.dart';

import '/gen/assets.gen.dart';
import '/core/extensions/extensions.dart';
import '/ui/auth/widgets/intro_content.dart';
import '/ui/auth/widgets/intro_navigation_button.dart';

class InitialSetUpScreen extends StatelessWidget {
  const InitialSetUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  context.l.intro_title,
                  style: context.textTheme.titleLarge,
                ),
                const SizedBox(height: 40),
                Image.asset(
                  Assets.images.introLogo.path,
                  width: 180,
                  height: 180,
                ),
                const SizedBox(height: 40),
                const IntroContent(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const IntroNavigationButton(),
      ),
    );
  }
}
