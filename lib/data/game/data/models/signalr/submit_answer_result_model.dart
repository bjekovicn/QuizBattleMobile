import 'package:json_annotation/json_annotation.dart';

part 'submit_answer_result_model.g.dart';

@JsonSerializable()
class SubmitAnswerResultModel {
  final bool accepted;
  final int submittedAt;

  const SubmitAnswerResultModel({
    required this.accepted,
    required this.submittedAt,
  });

  factory SubmitAnswerResultModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitAnswerResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitAnswerResultModelToJson(this);
}
