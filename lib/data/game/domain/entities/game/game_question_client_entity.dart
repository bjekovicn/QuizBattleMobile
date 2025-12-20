class GameQuestionClientEntity {
  final int questionId;
  final int roundNumber;
  final String text;
  final String optionA;
  final String optionB;
  final String optionC;
  // Note: No correctOption - server doesn't send this to client for security!

  const GameQuestionClientEntity({
    required this.questionId,
    required this.roundNumber,
    required this.text,
    required this.optionA,
    required this.optionB,
    required this.optionC,
  });

  GameQuestionClientEntity copyWith({
    int? questionId,
    int? roundNumber,
    String? text,
    String? optionA,
    String? optionB,
    String? optionC,
  }) {
    return GameQuestionClientEntity(
      questionId: questionId ?? this.questionId,
      roundNumber: roundNumber ?? this.roundNumber,
      text: text ?? this.text,
      optionA: optionA ?? this.optionA,
      optionB: optionB ?? this.optionB,
      optionC: optionC ?? this.optionC,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameQuestionClientEntity &&
          runtimeType == other.runtimeType &&
          questionId == other.questionId &&
          roundNumber == other.roundNumber;

  @override
  int get hashCode => Object.hash(questionId, roundNumber);
}
