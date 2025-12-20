import 'package:json_annotation/json_annotation.dart';
import 'game_player_model.dart';
import 'game_question_model.dart';

part 'game_room_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GameRoomModel {
  final String id;
  final int gameType;
  final int status;
  final String languageCode;
  final int totalRounds;
  final int currentRound;
  final int? hostPlayerId;
  final int createdAt;
  final int? startedAt;
  final int? roundStartedAt;
  final int? roundEndsAt;
  final List<GamePlayerModel> players;
  final List<GameQuestionModel> questions;

  const GameRoomModel({
    required this.id,
    required this.gameType,
    required this.status,
    required this.languageCode,
    required this.totalRounds,
    required this.currentRound,
    this.hostPlayerId,
    required this.createdAt,
    this.startedAt,
    this.roundStartedAt,
    this.roundEndsAt,
    required this.players,
    required this.questions,
  });

  factory GameRoomModel.fromJson(Map<String, dynamic> json) =>
      _$GameRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameRoomModelToJson(this);
}
