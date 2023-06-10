public class OrcEntity extends HumanoidEntity {

  AI<OrcEntity> AI;

  public OrcEntity(int x, int y) {
    super(x, y, 1, 1, Race.ORC, Team.Enemy);
    if (random(1) < 0.1) {
      AI = new OrcAIHunter(this, GAME.player);
    } else {
      AI = new OrcAISimple();
    }
    generateEquipment();
  }

  private void generateEquipment() {
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

public class OrcAIHunter implements AI<OrcEntity> {

  private int moveTurnOffset;
  private int moveCooldown = 3;
  private GameObject target;

  public OrcAIHunter(OrcEntity orc, GameObject target) {
    this.target = target;
    moveTurnOffset = round(random(moveCooldown));
    orc.setTeamCertain(false);
    orc.setRaceCertain(false);
  }

  public void run(OrcEntity orc, int turnCount) {
    if ((turnCount + moveTurnOffset) % moveCooldown ==  0) {
      ArrayList<IVector> moves = new ArrayList<IVector>();
      moves.add(orc.getPosition().copy().add(1, 0));
      moves.add(orc.getPosition().copy().add( -1, 0));
      moves.add(orc.getPosition().copy().add(0, 1));
      moves.add(orc.getPosition().copy().add(0, -1));
      ArrayList<IVector> movesSorted = IVectorHelper.sortByDistance(moves, target.getPosition());
      while (movesSorted.size() > 0) {
        if (orc.moveOrAttack(movesSorted.get(0), GAME.tileMap)) break;
        movesSorted.remove(0);
      }
    }
  }
}

public class OrcAISimple implements AI<OrcEntity> {

  private int moveTurnOffset;
  private int moveCooldown = 2;

  public OrcAISimple() {
    moveTurnOffset = round(random(moveCooldown));
  }

  public void run(OrcEntity orc, int turnCount) {
    if ((turnCount + moveTurnOffset) % moveCooldown ==  0) { //Checks if should move this round.
      int checks = 0;
      IVector direction;
      IVector[] moves = new IVector[] {new IVector(1, 0), new IVector( -1, 0), new IVector(0, 1), new IVector(0, -1), new IVector(0, 0)};
      do {
        direction = moves[round(random(moves.length - 1))];
        checks++;
      } while (!orc.moveOrAttackRelative(direction, GAME.tileMap) && checks < 20);
    }
  }
}
