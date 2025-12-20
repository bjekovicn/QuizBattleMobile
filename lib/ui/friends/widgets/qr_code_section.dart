import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/extensions/extensions.dart';
import '/ui/friends/state/friends_bloc.dart';
import '/ui/friends/screens/qr_image_screen.dart';
import '/ui/friends/screens/qr_scanner_screen.dart';

class QrCodeSection extends StatelessWidget {
  const QrCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple,
            Colors.deepPurple,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _QRActionContainer(
            text: context.l.qr_display,
            onTap: () => _toShowQRScreen(context),
            child: const Icon(
              size: 44,
              color: Colors.white,
              Icons.qr_code_2_outlined,
            ),
          ),
          Text(
            context.l.qr_instruction,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium!.copyWith(
              color: Colors.white,
            ),
          ),
          _QRActionContainer(
            text: context.l.qr_scan,
            onTap: () => _toScanQRScreen(context),
            child: const Icon(
              size: 44,
              color: Colors.white,
              Icons.qr_code_scanner,
            ),
          ),
        ],
      ),
    );
  }

  void _toScanQRScreen(BuildContext context) {
    context.nav.push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<FriendsBloc>(),
          child: const QRScannerScreen(),
        ),
      ),
    );
  }

  void _toShowQRScreen(BuildContext context) {
//TODO Fix static user id
    context.nav.push(
      MaterialPageRoute(
        builder: (_) => QRImageScreen(
          '1',
        ),
      ),
    );
  }
}

class _QRActionContainer extends StatelessWidget {
  const _QRActionContainer({
    required this.onTap,
    required this.child,
    required this.text,
  });

  final void Function() onTap;
  final Widget child;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            splashColor: Colors.purple..withValues(alpha: 0.5),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple.shade700,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.amber,
                ),
              ),
              child: child,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
