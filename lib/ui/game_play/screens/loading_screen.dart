import 'package:flutter/material.dart';
import 'package:quizcleandemo/ui/shared/widgets/common_loading.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CommonLoading(text: message),
      ),
    );
  }
}
