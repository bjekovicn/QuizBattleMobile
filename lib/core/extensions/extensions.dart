import 'package:flutter/material.dart';

import 'package:quizcleandemo/core/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  NavigatorState get nav => Navigator.of(this);

  AppLocalizations get l => AppLocalizations.of(this)!;

  Size get size => MediaQuery.of(this).size;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ScaffoldMessengerState get sm => ScaffoldMessenger.of(this);

  ModalRoute<Object?>? get route => ModalRoute.of(this);
}

extension FullName on Locale {
  String get fullName {
    switch (languageCode) {
      case 'en':
        return 'English';

      case 'sr':
        return 'Srpski';

      case 'de':
        return 'Deutsch';
    }
    return '';
  }
}
