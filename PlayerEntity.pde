public class PlayerEntity extends HumanoidEntity {

  public PlayerEntity(int x, int y) {
    super(x, y, 3, 1, Race.HUMAN, Team.Player);
    this.rightHandItem = new wep_Sword(Material.WOOD, Material.WOOD);
    this.leftHandItem = new wep_Axe(Material.WOOD, Material.WOOD);
    this.leftHandItem.face_right = false;
    this.helmet = new arm_Helmet(Material.HELLRITE);
  }
  public void onTurn(int turnCount) {
    super.onTurn(turnCount);
  }
  public void onDeath() {
  }
}
