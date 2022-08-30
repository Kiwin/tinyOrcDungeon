public class PlayerEntity extends HumanoidEntity {

  public PlayerEntity(int x, int y) {
    super(x, y, 3, 1, Race.HUMAN, Team.Player);
    this.rightHandItem = new Sword(Material.WOOD, Material.WOOD);
    this.leftHandItem = new Axe(Material.WOOD, Material.WOOD);
    this.leftHandItem.face_right = false;
    this.helmet = new Helmet(Material.HELLRITE);
  }
  public void onTurn(int turnCount) {
    super.onTurn(turnCount);
  }
  public void onDeath() {
  }
}
