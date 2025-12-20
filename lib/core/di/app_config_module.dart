import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppConfig {
  final String googleClientId;
  final String googleServerClientId;
  final String baseUrl;
  final String signalRHubUrl;

  AppConfig({
    required this.baseUrl,
    required this.googleClientId,
    required this.googleServerClientId,
    required this.signalRHubUrl,
  });

  @factoryMethod
  factory AppConfig.fromEnv() {
    return AppConfig(
      baseUrl: dotenv.env['BASE_URL'] ?? '',
      googleClientId: dotenv.env['GOOGLE_CLIENT_ID'] ?? '',
      googleServerClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? '',
      signalRHubUrl: dotenv.env['SIGNALR_HUB_URL'] ?? '',
    );
  }
}
