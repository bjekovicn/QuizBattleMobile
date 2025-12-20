enum GameType {
  randomDuel(1),
  randomBattle(2),
  friendDuel(3),
  friendBattle(4);

  const GameType(this.value);
  final int value;
}
