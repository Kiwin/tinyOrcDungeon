public class Human extends HumanoidEntity {

  public Human(int x, int y) {
    super(x, y, 3, 1, Race.HUMAN, Team.Player);
  }
  public void onTurn(int turnCount) {
    super.onTurn(turnCount);
  }
  public void onDeath() {
  }
}
