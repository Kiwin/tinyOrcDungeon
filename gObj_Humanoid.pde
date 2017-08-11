public abstract class gObj_Humanoid extends GameObject {

  public Item rightHandItem;
  public Item leftHandItem;
  public arm_Helmet helmet;
  public arm_Chestplate chestplate;

  public gObj_Humanoid(int x, int y, int hp, int str, Race race, Team team) {
    super(x, y, hp, str, race, team);
    this.rightHandItem = null;
    this.leftHandItem = null;
  }

  public void draw(float xOffset, float yOffset, float tileWidth, float tileHeight) {
    //Calculate
    float x = xOffset+this.render_position.x*tileWidth;
    float y = yOffset+this.render_position.y*tileHeight-tileHeight*0.15;
    float n = frameCount*0.05;
    float normalShake = sin(n)*tileWidth*0.020;
    float victoryShake = sin(n*2)*tileWidth*0.1;
    float victoryHeadShake = sin(n*2)*tileWidth*0.05;
    boolean dance = GAMEOVER || VICTORY;
    //Body
    fill(255);
    rect(x+tileWidth*0.3, y+tileHeight*0.50, tileWidth*0.4, tileHeight*0.5);
    //Head
    fill(this.race.skinColor);
    rect(x+tileWidth*0.4, y+tileWidth*0.35+(dance?victoryHeadShake:normalShake), tileWidth*0.2, tileHeight*0.2);
    if (this.rightHandItem != null) {
      this.rightHandItem.draw(x+tileWidth*0.8, y+tileWidth*0.6-(dance?victoryShake:normalShake), tileWidth, tileHeight);
    }
    if (this.leftHandItem != null) {
      this.leftHandItem.draw(x+tileWidth*0.2, y+tileWidth*0.6-(dance?victoryShake:normalShake), tileWidth, tileHeight);
    }
  }

  public void update() {
    this.render_position.lerp(this.position.toPVector(), 0.1);
    if (this.render_position.dist(this.position.toPVector()) < 0.01) {
      this.render_position = this.position.toPVector();
    }
  }
}