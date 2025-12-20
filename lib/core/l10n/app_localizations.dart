import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_sr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('sr')
  ];

  /// No description provided for @local_name.
  ///
  /// In sr, this message translates to:
  /// **'sr'**
  String get local_name;

  /// No description provided for @intro_title.
  ///
  /// In sr, this message translates to:
  /// **'Dobrodošli u Trivia Duel!'**
  String get intro_title;

  /// No description provided for @intro_subtitle1.
  ///
  /// In sr, this message translates to:
  /// **'Pridružite se borbi znanja gde brzina i mudrost dolaze do izražaja! Takmičite se protiv svojih prijatelja ili igrača iz celog sveta u uzbudljivom kvizu.'**
  String get intro_subtitle1;

  /// No description provided for @select_language.
  ///
  /// In sr, this message translates to:
  /// **'Izaberite jezik'**
  String get select_language;

  /// No description provided for @next.
  ///
  /// In sr, this message translates to:
  /// **'Dalje'**
  String get next;

  /// No description provided for @back.
  ///
  /// In sr, this message translates to:
  /// **'Nazad'**
  String get back;

  /// No description provided for @log_in_info.
  ///
  /// In sr, this message translates to:
  /// **'Da biste nastavili sa korišćenjem aplikacije, potrebno je da registrujete svoj nalog izborom opcije Google Prijava.'**
  String get log_in_info;

  /// No description provided for @google_sign_in.
  ///
  /// In sr, this message translates to:
  /// **'Google Prijava'**
  String get google_sign_in;

  /// No description provided for @google_sign_in_info.
  ///
  /// In sr, this message translates to:
  /// **'Da biste nastavili, potrebno je da registrujete svoj nalog pomoću opcije Google Prijava...'**
  String get google_sign_in_info;

  /// No description provided for @home.
  ///
  /// In sr, this message translates to:
  /// **'Početna'**
  String get home;

  /// No description provided for @friends.
  ///
  /// In sr, this message translates to:
  /// **'Prijatelji'**
  String get friends;

  /// No description provided for @rankings.
  ///
  /// In sr, this message translates to:
  /// **'Rang liste'**
  String get rankings;

  /// No description provided for @duel_battle.
  ///
  /// In sr, this message translates to:
  /// **'Duel Bitka'**
  String get duel_battle;

  /// No description provided for @error_occurred.
  ///
  /// In sr, this message translates to:
  /// **'Ups, nešto je pošlo po zlu...'**
  String get error_occurred;

  /// No description provided for @no_route_found.
  ///
  /// In sr, this message translates to:
  /// **'Putanja nije pronađena'**
  String get no_route_found;

  /// No description provided for @app_name.
  ///
  /// In sr, this message translates to:
  /// **'Naziv aplikacije'**
  String get app_name;

  /// No description provided for @success.
  ///
  /// In sr, this message translates to:
  /// **'Uspeh'**
  String get success;

  /// No description provided for @bad_request_error.
  ///
  /// In sr, this message translates to:
  /// **'Došlo je do problema sa zahtevom koji ste poslali. Molimo vas da proverite informacije i pokušate ponovo.'**
  String get bad_request_error;

  /// No description provided for @no_content.
  ///
  /// In sr, this message translates to:
  /// **'Trenutno nema dostupnog sadržaja. Molimo pokušajte ponovo kasnije.'**
  String get no_content;

  /// No description provided for @forbidden_error.
  ///
  /// In sr, this message translates to:
  /// **'Nemate dozvolu za pristup ovom resursu. Molimo vas da kontaktirate podršku ako mislite da je ovo greška.'**
  String get forbidden_error;

  /// No description provided for @unauthorized_error.
  ///
  /// In sr, this message translates to:
  /// **'Morate biti prijavljeni da biste izvršili ovu radnju. Molimo vas da se prijavite i pokušate ponovo.'**
  String get unauthorized_error;

  /// No description provided for @not_found_error.
  ///
  /// In sr, this message translates to:
  /// **'Resurs koji tražite nije pronađen. Možda je premešten ili obrisan.'**
  String get not_found_error;

  /// No description provided for @conflict_error.
  ///
  /// In sr, this message translates to:
  /// **'Došlo je do sukoba sa vašim zahtevom. Ovo može biti uzrokovano duplim podacima ili sličnim problemom.'**
  String get conflict_error;

  /// No description provided for @internal_server_error.
  ///
  /// In sr, this message translates to:
  /// **'Nešto nije u redu na našoj strani. Molimo vas da pokušate ponovo kasnije ili kontaktirate podršku ako problem potraje.'**
  String get internal_server_error;

  /// No description provided for @unknown_error.
  ///
  /// In sr, this message translates to:
  /// **'Došlo je do neočekivane greške. Molimo vas da pokušate ponovo ili kontaktirate podršku za pomoć.'**
  String get unknown_error;

  /// No description provided for @timeout_error.
  ///
  /// In sr, this message translates to:
  /// **'Zahtev je trajao predugo da bi se završio. Molimo vas da proverite vašu internet konekciju i pokušate ponovo.'**
  String get timeout_error;

  /// No description provided for @default_error.
  ///
  /// In sr, this message translates to:
  /// **'Došlo je do greške prilikom obrade vašeg zahteva. Molimo vas da pokušate ponovo kasnije.'**
  String get default_error;

  /// No description provided for @cache_error.
  ///
  /// In sr, this message translates to:
  /// **'Došlo je do problema prilikom preuzimanja keširanih podataka. Molimo vas da osvežite stranicu ili pokušate ponovo.'**
  String get cache_error;

  /// No description provided for @no_internet_error.
  ///
  /// In sr, this message translates to:
  /// **'Izgleda da ste offline. Molimo vas da proverite vašu internet konekciju i pokušate ponovo.'**
  String get no_internet_error;

  /// No description provided for @tokens.
  ///
  /// In sr, this message translates to:
  /// **'Tokeni'**
  String get tokens;

  /// No description provided for @coins.
  ///
  /// In sr, this message translates to:
  /// **'Novčići'**
  String get coins;

  /// No description provided for @welcome.
  ///
  /// In sr, this message translates to:
  /// **'Dobro došli'**
  String get welcome;

  /// No description provided for @added_success.
  ///
  /// In sr, this message translates to:
  /// **'Prijatelj uspešno dodat'**
  String get added_success;

  /// No description provided for @removed_success.
  ///
  /// In sr, this message translates to:
  /// **'Prijatelj uspešno uklonjen'**
  String get removed_success;

  /// No description provided for @requests.
  ///
  /// In sr, this message translates to:
  /// **'Zahtevi'**
  String get requests;

  /// No description provided for @no_friends_found.
  ///
  /// In sr, this message translates to:
  /// **'Nema pronaćenih prijatelja'**
  String get no_friends_found;

  /// No description provided for @no_requests_found.
  ///
  /// In sr, this message translates to:
  /// **'Nema pronađenih zahtjeva'**
  String get no_requests_found;

  /// No description provided for @loading.
  ///
  /// In sr, this message translates to:
  /// **'Učitavanje'**
  String get loading;

  /// No description provided for @qr_scan.
  ///
  /// In sr, this message translates to:
  /// **'QR Skeniranje'**
  String get qr_scan;

  /// No description provided for @qr_display.
  ///
  /// In sr, this message translates to:
  /// **'QR Prikaz'**
  String get qr_display;

  /// No description provided for @qr_instruction.
  ///
  /// In sr, this message translates to:
  /// **'Koristi QR\nda se povežeš\nsa prijateljima'**
  String get qr_instruction;

  /// No description provided for @add_friend.
  ///
  /// In sr, this message translates to:
  /// **'Dodaj prijatelja'**
  String get add_friend;

  /// No description provided for @challenge_friend.
  ///
  /// In sr, this message translates to:
  /// **'Izazovi prijatelja'**
  String get challenge_friend;

  /// No description provided for @remove_friend.
  ///
  /// In sr, this message translates to:
  /// **'Ukloni prijatelja'**
  String get remove_friend;

  /// No description provided for @game_starting.
  ///
  /// In sr, this message translates to:
  /// **'Trenutno smo u procesu povezivanja Vas sa Vašim protivnicima. Vaša igra će početi uskoro. Molimo vas za malo strpljenja 😊'**
  String get game_starting;

  /// No description provided for @random_opponent_duel.
  ///
  /// In sr, this message translates to:
  /// **'Brzi jedan-na-jedan kviz duel sa slučajnim protivnikom – uskoči i testiraj svoje veštine!'**
  String get random_opponent_duel;

  /// No description provided for @challenge_friend_duel.
  ///
  /// In sr, this message translates to:
  /// **'Jedan-na-jedan kviz duel sa prijateljem – pošalji izazov i saznaj ko je pravi majstor kviza!'**
  String get challenge_friend_duel;

  /// No description provided for @challenge_friends_battle.
  ///
  /// In sr, this message translates to:
  /// **'Kviz bitka sa prijateljima – pozovi ih na uzbudljiv grupni okršaj!'**
  String get challenge_friends_battle;

  /// No description provided for @random_opponent.
  ///
  /// In sr, this message translates to:
  /// **'Slučajni protivnik'**
  String get random_opponent;

  /// No description provided for @challenge_a_friend.
  ///
  /// In sr, this message translates to:
  /// **'Izazovi prijatelja'**
  String get challenge_a_friend;

  /// No description provided for @challenge_friends.
  ///
  /// In sr, this message translates to:
  /// **'Izazovi prijatelje'**
  String get challenge_friends;

  /// No description provided for @game_challenge_title.
  ///
  /// In sr, this message translates to:
  /// **'Izazov u igri'**
  String get game_challenge_title;

  /// No description provided for @invitation_message.
  ///
  /// In sr, this message translates to:
  /// **'te pozvao/la da se pridružiš Trivia Quiz Bitci! 🧠'**
  String get invitation_message;

  /// No description provided for @accept_challenge_question.
  ///
  /// In sr, this message translates to:
  /// **'Da li prihvataš izazov?'**
  String get accept_challenge_question;

  /// No description provided for @decline_button.
  ///
  /// In sr, this message translates to:
  /// **'Odbij'**
  String get decline_button;

  /// No description provided for @accept_button.
  ///
  /// In sr, this message translates to:
  /// **'Prihvati'**
  String get accept_button;

  /// No description provided for @noUsersInGameRoom.
  ///
  /// In sr, this message translates to:
  /// **'Nema korisnika u sobi za igru. Da biste započeli igru, morate dodati barem jednog prijatelja u sobu.'**
  String get noUsersInGameRoom;

  /// No description provided for @startGameButton.
  ///
  /// In sr, this message translates to:
  /// **'Započni igru'**
  String get startGameButton;

  /// No description provided for @creatingGameRoom.
  ///
  /// In sr, this message translates to:
  /// **'Kreiranje sobe za igru'**
  String get creatingGameRoom;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'sr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'sr':
      return AppLocalizationsSr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
