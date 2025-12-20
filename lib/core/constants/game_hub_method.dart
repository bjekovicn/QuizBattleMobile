enum GameHubMethod {
  createRoom('CreateRoom'),
  joinRoom('JoinRoom'),
  leaveRoom('LeaveRoom'),
  setReady('SetReady'),
  startGame('StartGame'),
  startRound('StartRound'),
  submitAnswer('SubmitAnswer'),
  endRound('EndRound'),
  endGame('EndGame'),
  joinMatchmaking('JoinMatchmaking'),
  leaveMatchmaking('LeaveMatchmaking'),
  getCurrentRoom('GetCurrentRoom'),
  getRoom('GetRoom');

  final String methodName;
  const GameHubMethod(this.methodName);

  @override
  String toString() => methodName;
}
