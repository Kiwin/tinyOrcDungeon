public class OrcEntity extends HumanoidEntity {
  
  private final int moveTurnOffset;
  
  public OrcEntity(int x, int y) {
    super(x, y, 1, 1, Race.ORC, Team.Enemy);
    moveTurnOffset = round(random(1));
    float ran = random(1);
    if (ran <= 0.25) {
      this.helmet = new Helmet(Material.WOOD);
    } else if (ran <= 0.40) {
      this.helmet = new Helmet(Material.IRON);
    } else if (ran <= 0.50) {
      this.helmet = new Helmet(Material.COBALT);
    }
    rightHandItem = new Sword(Material.WOOD, Material.WOOD);
    if (leftHandItem != null) {
      leftHandItem.face_right = false;
    }
  }
  @Override
  public void onTurn(int turnCount) {
    super.onTurn(turnCount);
    if ((turnCount + moveTurnOffset) % 2 ==  0) { //Checks if should move this round.
      int checks = 0;
      IVector direction;
      IVector[] directions = new IVector[] {new IVector(1,0), new IVector( -1,0), new IVector(0,1), new IVector(0, -1)}; 
      do{
        direction = directions[round(random(directions.length - 1))];
        checks++;
      } while(!this.moveOrAttackRelative(direction, tileMap) && checks < 20);
    }
  }
  public void onDeath() {
  }
}
