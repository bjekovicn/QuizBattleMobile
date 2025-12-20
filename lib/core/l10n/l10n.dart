import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quizcleandemo/core/l10n/app_localizations.dart';

class L10n {
  static const supportedLocales = [
    Locale('en'),
    Locale('sr'),
    Locale('de'),
  ];

  static const configuration = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const locale = Locale('en');

  static Locale getLocaleByLanguageCode(String languageCode) {
    return supportedLocales.firstWhere(
      (locale) => locale.languageCode == languageCode,
      orElse: () => locale,
    );
  }
}
