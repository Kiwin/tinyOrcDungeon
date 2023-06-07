public abstract class GameObject {

  //Meta fields
  public boolean deleteable;

  //Position fields
  private IVector position;
  private PVector renderPosition;

  //Combat fields
  private int health; //Variable describes the GameObjects current health.
  private int healthMax; //Variable describes how much health the GameObject maximum can have.
  private int strength; //Variable describes how much damage the GameObject can deal.
  private boolean healable; //Variable used to dictate of the GameObject can heal.
  private boolean teamCertain;
  private boolean raceCertain;

  //Team & Identification fields
  public final Race race;
  public Team team;

  public GameObject(int x, int y, int hp, int str, Race race, Team team) {
    this.position = new IVector(x, y);
    this.renderPosition = position.toPVector();
    this.healable = true;
    this.health = hp;
    this.healthMax = hp;
    this.strength = str;
    this.race = race;
    this.team = team;
    this.teamCertain = true;
    this.raceCertain = true;
    this.deleteable = true;
  }

  public boolean isAlive() {
    return health > 0;
  }

  public void heal(int healingPoints) {
    if (this.healable) {
      this.health += healingPoints;
      this.health = constrain(this.health, 0, this.healthMax);
    }
  }

  public void takeDamage(int damagePoints) {
    this.health -= damagePoints;
  }

  //Method that makes a given GameObject take damage;
  //GameObject Will not attack if same race or team by default.
  public void attack(GameObject target) {
    if (this.isAlive()) {
      if ((!teamCertain || this.team != target.team) && (!raceCertain || this.race != target.race)) {
        target.takeDamage(this.strength);
        this.onAttack(target);
      }
    }
  }

  // Moves the GameObject to a position or attacking if moving is not possible.
  // Returns if the player successfully performed the action.
  public boolean moveOrAttack(IVector newPosition, TileMap tileMap) {
    if (tileIsOccupied(newPosition, tileMap, GAME.objectHandler) && !tileMap.getTile(newPosition).isSolid()) {
      GameObject target = GAME.objectHandler.getObjectAt(newPosition);
      if (target != null) {
        this.attack(target);
        return true;
      } else {
        return false;
      }
    } else {
      return moveTo(newPosition, tileMap);
    }
  }

  public boolean moveOrAttackRelative(IVector newPosition, TileMap tileMap) {
    return moveOrAttack(newPosition.copy().add(position), tileMap);
  }

  //Method that moves the GameObject in a direction if possible.
  //Method returns if the player successfully performed the action.
  public boolean moveTo(IVector newPosition, TileMap tileMap) {
    if (this.canMoveTo(newPosition, tileMap)) { //Can move to new position.
      this.position = newPosition;
      return true;
    } else { //Can't move to new position.
      return false;
    }
  }

  //method that returns if the GameObject can move to the given position
  public boolean canMoveTo(IVector position, TileMap tileMap) {
    return !tileIsOccupied(position, tileMap, GAME.objectHandler);
  }

  public void kill() {
    this.health = 0;
    this.healable = false;
  }

  private void onAttack(GameObject target) {
    renderPosition.add(target.position.toPVector()).div(2);
  }
  //---Getters and Setters---//
  public int getHealth() {
    return this.health;
  }

  public void setHealth(int health) {
    this.health = health;
  }

  public IVector getPosition() {
    return this.position.copy();
  }

  public void setPosition(IVector position) {
    this.position = position;
  }

  public PVector getRenderPosition() {
    return this.renderPosition;
  }

  public void setRenderPosition(PVector position) {
    this.renderPosition = position;
  }

  public boolean isTeamCertain() {
    return this.teamCertain;
  }

  
  public void setTeamCertain(boolean isTeamCertain){
    this.teamCertain = isTeamCertain;
  }
  
  public boolean isRaceCertain() {
    return this.raceCertain;
  }

  public void setRaceCertain(boolean isRaceCertain){
    this.raceCertain = isRaceCertain;
  }

  //---Abstract methods---//
  public abstract int getStrength();
  public abstract int getArmor();
  public abstract void update();
  public abstract void render(float xOffset, float yOffset, float tileWidth, float tileHeight);

  //---Abstract "listeners"---//
  public abstract void onDeath(); //Should be called once when the GameObject dies.
  public abstract void onTurnBegin(int turnCount); //Should be called first and once when a turn ends.
  public abstract void onTurn(int turnCount); //Should be called once between onTurnBegin and onTurnEnd is called.
  public abstract void onTurnEnd(int turnCount); //Should be called last and once when a turn ends.
}
