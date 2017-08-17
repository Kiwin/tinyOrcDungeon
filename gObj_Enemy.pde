public class gObj_Orc extends gObj_Humanoid {

  private final int moveTurnOffset;

  public gObj_Orc(int x, int y) {
    super(x, y, 1, 1, Race.ORC, Team.Enemy);
    moveTurnOffset = round(random(1));
    float ran = random(1);
    if (ran < 0.20) {
      rightHandItem = new wep_Sword(Material.WOOD, Material.IRON);
    } else if (ran < 0.40) {
      rightHandItem = new wep_Axe(Material.WOOD, Material.IRON);
    } else if (ran < 0.60) {
      rightHandItem = new wep_Sword(Material.IRON, Material.COBALT);
    }
    ran = random(1);
    if (ran < 0.20) {
      leftHandItem = new wep_Sword(Material.WOOD, Material.IRON);
    } else if (ran < 0.40) {
      leftHandItem = new wep_Axe(Material.WOOD, Material.IRON);
    } else if (ran < 0.60) {
      leftHandItem = new wep_Sword(Material.IRON, Material.COBALT);
    }
    if (leftHandItem != null) {
      leftHandItem.face_right = false;
    }
  }

  public void onTurn(int turnCount) {
    if ((turnCount+moveTurnOffset)%2==0) { //Checks if should move this round.
      int checks = 0;
      Direction direction;
      do {
        direction = Direction.values()[round(random(Direction.values().length-1))];
        checks++;
      } while (!this.moveOrAttack(direction) && checks < 20);
    }
  }
  public void onDeath() {
  }
}