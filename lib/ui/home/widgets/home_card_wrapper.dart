import 'package:flutter/material.dart';

class HomeCardWrapper extends StatelessWidget {
  const HomeCardWrapper({
    super.key,
    required this.child,
    this.padding,
  });
  final Widget child;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 14,
          ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromRGBO(97, 52, 107, 1),
            Colors.purple.shade900,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.amber,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black..withValues(alpha: 0.4),
            blurRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
