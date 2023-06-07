public abstract class HumanoidEntity extends GameObject {

  public BaseTool rightHandItem;
  public BaseTool leftHandItem;
  public Helmet helmet;
  public Chestplate chestplate;

  public HumanoidEntity(int x, int y, int hp, int str, Race race, Team team) {
    super(x, y, hp, str, race, team);
  }

  public void render(float xOffset, float yOffset, float tileWidth, float tileHeight) {
    //Calculate
    float x = xOffset+getRenderPosition().x*tileWidth;
    float y = yOffset+getRenderPosition().y*tileHeight-tileHeight*0.15;
    float n = frameCount*0.05;
    float normalShake = sin(n)*tileWidth*0.020;
    float victoryShake = sin(n*2)*tileWidth*0.1;
    float victoryHeadShake = sin(n*2)*tileWidth*0.05;
    boolean dance = GAME.GAMEOVER || GAME.VICTORY;
    float headX = x+tileWidth*0.4;
    float headY = y+tileWidth*0.35+(dance?victoryHeadShake:normalShake);
    float headW = tileWidth*0.2;
    float headH = tileWidth*0.2;
    //Body
    fill(255);
    rect(x+tileWidth*0.3, y+tileHeight*0.50, tileWidth*0.4, tileHeight*0.5);
    //Head
    fill(race.skinColor);
    rect(headX, headY, headW, headH);
    if (this.rightHandItem != null) {
      this.rightHandItem.render(x+tileWidth*0.8, y+tileWidth*0.6-(dance?victoryShake:normalShake), tileWidth, tileHeight);
    }
    if (this.leftHandItem != null) {
      this.leftHandItem.render(x+tileWidth*0.2, y+tileWidth*0.6-(dance?victoryShake:normalShake), tileWidth, tileHeight);
    }
    if (this.helmet != null) {
      this.helmet.render(headX, headY, headW, headH);
    }
  }

  public void update() {
    this.getRenderPosition().lerp(getPosition().toPVector(), 0.1);
    if (getRenderPosition().dist(getPosition().toPVector()) < 0.01) {
      setRenderPosition(getPosition().toPVector());
    }
  }

  public int getStrength() {
    int str = getStrength();
    if (this.rightHandItem != null && this.rightHandItem instanceof BaseWeapon) {
      str += ((BaseWeapon) this.rightHandItem).getStrength();
    }
    if (this.leftHandItem != null && this.leftHandItem instanceof BaseWeapon) {
      str += ((BaseWeapon) this.leftHandItem).getStrength();
    }
    return str;
  }
  public int getArmor() {
    int arm = 0;
    if (this.helmet != null) {
      arm += this.helmet.getArmor();
    }
    if (this.chestplate != null) {
      arm += this.chestplate.getArmor();
    }
    return arm;
  }

  @Override
    public void takeDamage(int damagePoints) {
    int dmg = damagePoints;
    if (helmet != null) {
      dmg = helmet.blockDamage(dmg);
    }
    if (chestplate != null) {
      dmg = chestplate.blockDamage(dmg);
    }
    if (dmg > 0) {
       setHealth(getHealth()-dmg);
      //onTakeDamage
    }
  }
  public void onTurnBegin(int turnCount) {
  }
  public void onTurn(int turnCount) {
  }
  public void onTurnEnd(int turnCount) {
    if (this.rightHandItem != null) {
      if (this.rightHandItem.isBroken()) {
        this.rightHandItem = null;
      }
    }
    if (this.leftHandItem != null) {
      if (this.leftHandItem.isBroken()) {
        this.leftHandItem = null;
      }
    }
    if (this.helmet != null) {
      if (this.helmet.isBroken()) {
        this.helmet = null;
      }
    }
    if (this.chestplate != null) {
      if (this.chestplate.isBroken()) {
        this.chestplate = null;
      }
    }
  }
}
