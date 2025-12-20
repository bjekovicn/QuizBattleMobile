import 'package:quizcleandemo/data/game/domain/entities/game/game_question_client_entity.dart';

class RoundStartedEventEntity {
  final int currentRound;
  final int totalRounds;
  final GameQuestionClientEntity question;
  final int roundEndsAt;

  const RoundStartedEventEntity({
    required this.currentRound,
    required this.totalRounds,
    required this.question,
    required this.roundEndsAt,
  });

  RoundStartedEventEntity copyWith({
    int? currentRound,
    int? totalRounds,
    GameQuestionClientEntity? question,
    int? roundEndsAt,
  }) {
    return RoundStartedEventEntity(
      currentRound: currentRound ?? this.currentRound,
      totalRounds: totalRounds ?? this.totalRounds,
      question: question ?? this.question,
      roundEndsAt: roundEndsAt ?? this.roundEndsAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundStartedEventEntity &&
          runtimeType == other.runtimeType &&
          currentRound == other.currentRound;

  @override
  int get hashCode => currentRound.hashCode;
}
