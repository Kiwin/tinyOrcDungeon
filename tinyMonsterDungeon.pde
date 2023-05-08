class GameSettings {
  
  //Mapping fields
  public final int mapWidth = 9;
  public final int mapHeight = 9;
  public final color[] tileColors = new color[] {0, 64, 96}; //{0, #ff6666, #66ff66, #6666ff, #ffff66, #66ffff};
  public final float viewportBorderMarginPercent = 10;
}

final Game GAME = new Game(new GameSettings());

void setup() {

  // Render settings
  size(800, 800);
  smooth(12);
  ellipseMode(CORNER);
  noStroke();

  GAME.start();
}

void draw() {
  GAME.update();
  GAME.render();
}

void keyPressed() {
  GAME.onKeyPressed(key);
}
