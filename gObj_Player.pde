public class gObj_Player extends gObj_Humanoid {

  public gObj_Player(int x, int y) {
    super(x, y, 5, 1, Race.HUMAN, Team.Player);
    this.armor = 3;
    this.rightHandItem = new wep_Axe();
    this.leftHandItem = new wep_Axe();
    this.leftHandItem.face_right = false;
  }
  public void onTurn(int turnCount) {
  }
  public void onDeath() {
  }
}