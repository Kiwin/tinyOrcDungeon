public class OrcEntity extends HumanoidEntity {

  AI<OrcEntity> AI;
  private int moveTurnOffset;

  public OrcEntity(int x, int y) {
    super(x, y, 1, 1, Race.ORC, Team.Enemy);
    AI = new OrcAISimple();
    generateEquipment();
  }

  void generateEquipment() {
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
      leftHandItem.isFacingRight = false;
    }
  }

  @Override
    public void onTurn(int turnCount) {
    super.onTurn(turnCount);
    AI.run(this, turnCount);
  }
  public void onDeath() {
  }
}

interface AI<T> {
  void run(T actor, int turnCount);
}

/*class OrcAIHunter implements AI<OrcEntity> {
  public void run(OrcEntity orc, int turnCount) {
    if ((turnCount + orc.moveTurnOffset) % 2 ==  0) { //Checks if should move this round.
      int checks = 0;
      IVector[] directions = new IVector[] {new IVector(1, 0), new IVector( -1, 0), new IVector(0, 1), new IVector(0, -1)};
      IVector bestDirection;
    }
  }
}*/

class OrcAISimple implements AI<OrcEntity> {
  public void run(OrcEntity orc, int turnCount) {
    if ((turnCount + orc.moveTurnOffset) % 2 ==  0) { //Checks if should move this round.
      int checks = 0;
      IVector direction;
      IVector[] directions = new IVector[] {new IVector(1, 0), new IVector( -1, 0), new IVector(0, 1), new IVector(0, -1), new IVector(0, 0)};
      do {
        direction = directions[round(random(directions.length - 1))];
        checks++;
      } while (!orc.moveOrAttackRelative(direction, GAME.tileMap) && checks < 20);
    }
  }
}
