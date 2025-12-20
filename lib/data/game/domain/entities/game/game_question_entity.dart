class GameQuestionEntity {
  final int questionId;
  final int roundNumber;
  final String text;
  final String optionA;
  final String optionB;
  final String optionC;
  final String correctOption;

  const GameQuestionEntity({
    required this.questionId,
    required this.roundNumber,
    required this.text,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.correctOption,
  });

  GameQuestionEntity copyWith({
    int? questionId,
    int? roundNumber,
    String? text,
    String? optionA,
    String? optionB,
    String? optionC,
    String? correctOption,
  }) {
    return GameQuestionEntity(
      questionId: questionId ?? this.questionId,
      roundNumber: roundNumber ?? this.roundNumber,
      text: text ?? this.text,
      optionA: optionA ?? this.optionA,
      optionB: optionB ?? this.optionB,
      optionC: optionC ?? this.optionC,
      correctOption: correctOption ?? this.correctOption,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameQuestionEntity &&
          runtimeType == other.runtimeType &&
          questionId == other.questionId &&
          roundNumber == other.roundNumber;

  @override
  int get hashCode => Object.hash(questionId, roundNumber);
}
