// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get local_name => 'sr';

  @override
  String get intro_title => 'Welcome to Trivia Duel!';

  @override
  String get intro_subtitle1 =>
      'Join the ultimate battle of wits where knowledge meets speed! Compete against your friends or players from around the world in an exciting quiz showdown.';

  @override
  String get select_language => 'Select language';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get log_in_info =>
      'To continue using the app, you need to register your account by selecting the Google Sign-In option.';

  @override
  String get google_sign_in => 'Google Sign In';

  @override
  String get google_sign_in_info =>
      'To proceed you need to register your account using Google Sign In option...';

  @override
  String get home => 'Home';

  @override
  String get friends => 'Friends';

  @override
  String get rankings => 'Rankings';

  @override
  String get duel_battle => 'Duel Battle';

  @override
  String get error_occurred => 'Oops, something went wrong...';

  @override
  String get no_route_found => 'No route found';

  @override
  String get app_name => 'App Name';

  @override
  String get success => 'Success';

  @override
  String get bad_request_error =>
      'There was an issue with the request you made. Please check the information and try again.';

  @override
  String get no_content =>
      'There is no content available at the moment. Please try again later.';

  @override
  String get forbidden_error =>
      'You don\'t have permission to access this resource. Please contact support if you think this is an error.';

  @override
  String get unauthorized_error =>
      'You need to be logged in to perform this action. Please log in and try again.';

  @override
  String get not_found_error =>
      'The resource you are looking for could not be found. It might have been moved or deleted.';

  @override
  String get conflict_error =>
      'There was a conflict with your request. This could be due to duplicate data or a similar issue.';

  @override
  String get internal_server_error =>
      'Something went wrong on our end. Please try again later or contact support if the issue persists.';

  @override
  String get unknown_error =>
      'An unexpected error occurred. Please try again or contact support for assistance.';

  @override
  String get timeout_error =>
      'The request took too long to complete. Please check your internet connection and try again.';

  @override
  String get default_error =>
      'An error occurred while processing your request. Please try again later.';

  @override
  String get cache_error =>
      'There was an issue retrieving cached data. Please refresh the page or try again.';

  @override
  String get no_internet_error =>
      'It seems you\'re offline. Please check your internet connection and try again.';

  @override
  String get tokens => 'Tokens';

  @override
  String get coins => 'Coins';

  @override
  String get welcome => 'Welcome';

  @override
  String get added_success => 'Friend added successfully';

  @override
  String get removed_success => 'Friend removed successfully';

  @override
  String get requests => 'Requests';

  @override
  String get no_friends_found => 'There is no friends found';

  @override
  String get no_requests_found => 'There is no requests found';

  @override
  String get loading => 'Loading';

  @override
  String get qr_scan => 'QR Scan';

  @override
  String get qr_display => 'QR Display';

  @override
  String get qr_instruction => 'Use QR\nto Connect\nwith your Friends';

  @override
  String get add_friend => 'Add Friend';

  @override
  String get challenge_friend => 'Challenge Friend';

  @override
  String get remove_friend => 'Remove Friend';

  @override
  String get game_starting =>
      'Game will begin as soon as your opponent is found. Please hold on!';

  @override
  String get random_opponent_duel =>
      'Quick one-on-one trivia duel with a random opponent — jump in and test your skills!';

  @override
  String get challenge_friend_duel =>
      'One-on-one trivia duel with a friend — send a challenge and see who\'s the ultimate trivia master!';

  @override
  String get challenge_friends_battle =>
      'Multiplayer trivia battle with friends — invite them for a thrilling group showdown!';

  @override
  String get random_opponent => 'Random Opponent';

  @override
  String get challenge_a_friend => 'Challenge a Friend';

  @override
  String get challenge_friends => 'Challenge Friends';

  @override
  String get game_challenge_title => 'Game Challenge';

  @override
  String get invitation_message =>
      'invited you to join a Trivia Quiz Battle! 🧠';

  @override
  String get accept_challenge_question => 'Do you accept the challenge?';

  @override
  String get decline_button => 'Decline';

  @override
  String get accept_button => 'Accept';

  @override
  String get noUsersInGameRoom =>
      'There are no users in the game room. To start the game, you need to add at least one friend to the room.';

  @override
  String get startGameButton => 'Start Game';

  @override
  String get creatingGameRoom => 'Creating Game Room';
}
