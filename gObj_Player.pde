public class gObj_Player extends gObj_Humanoid {

  public gObj_Player(int x, int y) {
    super(x, y, 5, 1, Race.HUMAN, Team.Player);
    this.rightHandItem = new wep_Sword(Material.COBALT, Material.IRON);
    this.leftHandItem = new wep_Sword(Material.IRON, Material.COBALT);
    this.leftHandItem.face_right = false;
  }
  public void onTurn(int turnCount) {
  }
  public void onDeath() {
  }
}
