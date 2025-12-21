enum GameHubEvent {
  // Connection Events
  connect('Connect'),
  disconnect('Disconnect'),

  // Room Events (from server)
  roomCreated('RoomCreated'),
  playerJoined('PlayerJoined'),
  playerLeft('PlayerLeft'),
  playerReadyChanged('PlayerReadyChanged'),
  playerDisconnected('PlayerDisconnected'),
  playerReconnected('PlayerReconnected'),

  // Matchmaking Events (from server)
  matchmakingUpdate('MatchmakingUpdate'),
  matchFound('MatchFound'),

  // Game Flow Events (from server)
  gameStarting('GameStarting'),
  roundStarted('RoundStarted'),
  playerAnswered('PlayerAnswered'),
  roundEnded('RoundEnded'),
  gameEnded('GameEnded'),

  // Friend Battle Events
  inviteSent('InviteSent'),
  inviteReceived('InviteReceived'),
  inviteResponse('InviteResponse'),

  // Error Events
  error('Error');

  final String eventName;
  const GameHubEvent(this.eventName);

  @override
  String toString() => eventName;
}
