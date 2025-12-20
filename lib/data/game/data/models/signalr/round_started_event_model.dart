import 'package:json_annotation/json_annotation.dart';
import 'game_question_client_model.dart';

part 'round_started_event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RoundStartedEventModel {
  final int currentRound;
  final int totalRounds;
  final GameQuestionClientModel question;
  final int roundEndsAt;

  const RoundStartedEventModel({
    required this.currentRound,
    required this.totalRounds,
    required this.question,
    required this.roundEndsAt,
  });

  factory RoundStartedEventModel.fromJson(Map<String, dynamic> json) =>
      _$RoundStartedEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoundStartedEventModelToJson(this);
}
