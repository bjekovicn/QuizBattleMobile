/// PlayerAnswerEntity - Domain entity for player's answer
class PlayerAnswerEntity {
  final String answer;
  final int responseTimeMs;
  final int answeredAt;

  const PlayerAnswerEntity({
    required this.answer,
    required this.responseTimeMs,
    required this.answeredAt,
  });

  /// Get response time as Duration
  Duration get responseTime => Duration(milliseconds: responseTimeMs);

  /// Get answered time as DateTime
  DateTime get answeredAtDateTime =>
      DateTime.fromMillisecondsSinceEpoch(answeredAt);

  PlayerAnswerEntity copyWith({
    String? answer,
    int? responseTimeMs,
    int? answeredAt,
  }) {
    return PlayerAnswerEntity(
      answer: answer ?? this.answer,
      responseTimeMs: responseTimeMs ?? this.responseTimeMs,
      answeredAt: answeredAt ?? this.answeredAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAnswerEntity &&
          runtimeType == other.runtimeType &&
          answer == other.answer &&
          answeredAt == other.answeredAt;

  @override
  int get hashCode => answer.hashCode ^ answeredAt.hashCode;

  @override
  String toString() {
    return 'PlayerAnswerEntity(answer: $answer, responseTimeMs: $responseTimeMs)';
  }
}
