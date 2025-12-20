import 'package:quizcleandemo/data/game/data/models/signalr/round_started_event_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/round_started_event_entity.dart';

import 'game_question_client_mapper.dart';

extension RoundStartedEventModelMapper on RoundStartedEventModel {
  RoundStartedEventEntity toEntity() {
    return RoundStartedEventEntity(
      currentRound: currentRound,
      totalRounds: totalRounds,
      question: question.toEntity(),
      roundEndsAt: roundEndsAt,
    );
  }
}

extension RoundStartedEventEntityMapper on RoundStartedEventEntity {
  RoundStartedEventModel toModel() {
    return RoundStartedEventModel(
      currentRound: currentRound,
      totalRounds: totalRounds,
      question: question.toModel(),
      roundEndsAt: roundEndsAt,
    );
  }
}
