import 'package:json_annotation/json_annotation.dart';

part 'final_standing_model.g.dart';

@JsonSerializable()
class FinalStandingModel {
  final int position;
  final int userId;
  final String displayName;
  final String? photoUrl;
  final int totalScore;
  final String colorHex;

  const FinalStandingModel({
    required this.position,
    required this.userId,
    required this.displayName,
    this.photoUrl,
    required this.totalScore,
    required this.colorHex,
  });

  factory FinalStandingModel.fromJson(Map<String, dynamic> json) =>
      _$FinalStandingModelFromJson(json);

  Map<String, dynamic> toJson() => _$FinalStandingModelToJson(this);
}
