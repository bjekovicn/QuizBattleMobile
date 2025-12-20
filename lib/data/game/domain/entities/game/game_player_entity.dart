import 'player_answer_entity.dart';

class GamePlayerEntity {
  final int userId;
  final String displayName;
  final String? photoUrl;
  final String colorHex;
  final String colorName;
  final int totalScore;
  final int currentRoundScore;
  final bool isReady;
  final bool isConnected;
  final PlayerAnswerEntity? currentAnswer;
  final int joinedAt;

  const GamePlayerEntity({
    required this.userId,
    required this.displayName,
    this.photoUrl,
    required this.colorHex,
    required this.colorName,
    required this.totalScore,
    required this.currentRoundScore,
    required this.isReady,
    required this.isConnected,
    this.currentAnswer,
    required this.joinedAt,
  });

  bool get hasAnswered => currentAnswer != null;

  DateTime get joinedAtDateTime =>
      DateTime.fromMillisecondsSinceEpoch(joinedAt);

  GamePlayerEntity copyWith({
    int? userId,
    String? displayName,
    String? photoUrl,
    String? colorHex,
    String? colorName,
    int? totalScore,
    int? currentRoundScore,
    bool? isReady,
    bool? isConnected,
    PlayerAnswerEntity? currentAnswer,
    int? joinedAt,
  }) {
    return GamePlayerEntity(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      colorHex: colorHex ?? this.colorHex,
      colorName: colorName ?? this.colorName,
      totalScore: totalScore ?? this.totalScore,
      currentRoundScore: currentRoundScore ?? this.currentRoundScore,
      isReady: isReady ?? this.isReady,
      isConnected: isConnected ?? this.isConnected,
      currentAnswer: currentAnswer ?? this.currentAnswer,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GamePlayerEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    return 'GamePlayerEntity(userId: $userId, displayName: $displayName, score: $totalScore, isReady: $isReady)';
  }
}
