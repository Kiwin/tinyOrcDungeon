//Meta fields
public boolean GAMEOVER;
public boolean VICTORY;

//Mapping fields
public final int mapWidth = 9;
public final int mapHeight = 9;
public final float marginPercent = 0.2;
public final color[] tileColors = new color[] {0, 64, 96}; //{0, #ff6666, #66ff66, #6666ff, #ffff66, #66ffff};
public TileMap tileMap;
TileMapRenderer mapRenderer;

//Game-flow fields
public int turnCount;

//Render fields
float renderWidth;
float renderHeight;
float mapOffsetX;
float mapOffsetY;
float mapDisplayWidth;
float mapDisplayHeight;
float tileWidth; //Variable that describes the width of a tile;
float tileHeight; //Variable that describes the height of a tile;

//Entity fields
PlayerEntity player;
GameObjectHandler objects;

//Method that pre-processes stuff, setting settings and such.
void setup() {
  //Settings
  size(800, 800);

  //Render settings
  smooth(12);
  ellipseMode(CORNER);
  noStroke();

  initGame();
}

//Method that initializes the map, objects and ect.
void initGame() {
  //Variables
  calculateDisplayVariables();
  turnCount = 0;
  GAMEOVER = false;
  VICTORY = false;

  mapRenderer = new TileMapRenderer();

  objects = new GameObjectHandler();

  initNewMap();
  initNewLevel(true, objects, true, tileMap);
}

void initNewMap() {
  //Map
  tileMap = new TileMap(mapWidth, mapHeight);
  //map.randomizeMap(1, tileColors.length-1);
  tileMap.fillMapTiled(1, 2);
  tileMap.fillMapEgdes(0, true);
}

void initNewLevel(boolean initNewPlayer, GameObjectHandler objects, boolean killMobs, TileMap tileMap) {
  if (killMobs) {
    objects.clear();
  }

  if (initNewPlayer) {
    player = new PlayerEntity(1, 1);
  }
  player.position = new IVector(1, 1);
  objects.add(player);

  float enemyPerTile = 0.2;
  float enemyPerTileFactor = tileMap.getTileCount()*enemyPerTile;
  float enemyCount = floor(enemyPerTileFactor/2+random(enemyPerTileFactor/4));
  println("Spawning", enemyCount, "enemies");

  for (int i = 0; i < enemyCount; i++) {

    IVector position = new IVector();
    int triesRemaining = 10;
    do {
      position.x = round(random(0, mapWidth - 1));
      position.y = round(random(0, mapHeight - 1));
      triesRemaining--;
      println("attempting to spawn enemy at", position.x, position.y, triesRemaining);
    } while (triesRemaining > 0 && tileIsOccupied(position, tileMap));
    objects.add(new OrcEntity(position.x, position.y));
    if (triesRemaining > 0) {
      println("Enemy spawned", position.x, position.y, triesRemaining);
    } else {
      println("Failed to spawn enemy");
    }
    println("Enemies left to spawn:", enemyCount-i-1);
  }

  checkForWinCondition();
}

//Method that calculates where to display the map in the screen.
void calculateDisplayVariables() {
  float render_width = width;
  float render_height = height;

  float smallestDimension = min(render_width, render_height);
  /***
   Here we are creating a margin effect for the displayed map
   by scaling down the map display area accordingly to the 'marginPercent' variable,
   and afterwards calculating the offsets accordingly to the map display dimensions.
   ***/
  mapDisplayWidth = smallestDimension * (1 - marginPercent);
  mapDisplayHeight = mapDisplayWidth;
  mapOffsetX = (render_width - mapDisplayWidth) / 2;
  mapOffsetY = (render_height - mapDisplayHeight) / 2;

  float tileSize = min(mapDisplayWidth / mapWidth, mapDisplayHeight / mapHeight);
  tileWidth = tileSize;
  tileHeight = tileSize;
}

//Method that draws and updates the map, objects, ect.
void draw() {
  //Update
  objects.update();

  //Draw
  background(64);
  mapRenderer.draw(tileMap, mapOffsetX, mapOffsetY, tileWidth, tileHeight, tileColors);
  drawExitDoor();
  objects.draw(mapOffsetX, mapOffsetY, tileWidth, tileHeight);
  drawHealthBar(tileWidth * 0.2, tileHeight * 0.2, tileWidth * 0.8, tileHeight * 0.8);
}

void drawExitDoor() {
  fill(#984310);
  noStroke();
  rect((mapWidth - 2) * tileWidth + mapOffsetX, (mapHeight - 2) * tileHeight + mapOffsetY, tileWidth, tileHeight);
}

public void drawHealthBar(float x, float y, float w, float h) {
  float w2 = w * 0.9;
  pushMatrix();
  translate(x, y);

  for (int i = 0; i < player.getHealth(); i++) {
    //Draw Hearts
    float x2 = w2 * i;
    if (i == player.getHealth() - 1 && player.getArmor() == 0) {
      float n = sin(frameCount * 0.1) * 30;
      fill(164 + n, n, n);
    } else {
      fill(#880000);
    }
    beginShape();
    vertex(x2 + w * 0.25, 0);
    vertex(x2 + w * 0.5, h * 0.25);
    vertex(x2 + w * 0.75, 0);
    vertex(x2 + w, h * 0.50);
    vertex(x2 + w * 0.5, h);
    vertex(x2, h * 0.50);
    endShape(CLOSE);
  }

  //Draw Shields
  for (int i = player.getHealth(); i < player.getHealth() + player.getArmor(); i++) {
    float x2 = w2 * i;
    float c = 120 + i * 20;
    if (i == player.getHealth() + player.getArmor() - 1) {
      float n = sin(frameCount * 0.1) * 15;
      c += n;
    }
    fill(c);
    beginShape();
    vertex(x2 + w * 0.5, 0);
    vertex(x2 + 0, h * 0.5);
    vertex(x2 + w * 0.5, h);
    vertex(x2 + w, h * 0.5);
    endShape(CLOSE);
  }
  popMatrix();
}
public void onTurn() {
  if (!GAMEOVER) {
    objects.onTurnBegin(turnCount);
    objects.onTurn(turnCount);
    objects.onTurnEnd(turnCount);
    turnCount++;
    checkForWinCondition();
    checkForGameOverCondition();
  }
  if (player.getPosition().isEqualTo(new IVector(mapWidth - 2, mapHeight - 2))) {
    initNewLevel(false, objects, true, tileMap);
  }
}

void checkForGameOverCondition() {
  GAMEOVER = !player.isAlive();
}

void checkForWinCondition() {
  VICTORY = objects.size() == 1;
}


//---Controls methods---//
void mousePressed() {
}
void mouseReleased() {
}
void mouseClicked() {
}
void mouseWheel(MouseEvent me) {
}
void keyPressed() {
  switch(key) {
  case 'n':
    initGame();
    break;
  }
  if (GAMEOVER) return;
  handlePlayerAction(key);
}

void handlePlayerAction(char key) {
  boolean actionPerformed = false;
  switch(key) {
  case 'w':
    actionPerformed = player.moveOrAttackRelative(new IVector(0, -1), tileMap);
    break;
  case 's':
    actionPerformed = player.moveOrAttackRelative(new IVector(0, 1), tileMap);
    break;
  case 'a':
    actionPerformed = player.moveOrAttackRelative(new IVector( -1, 0), tileMap);
    break;
  case 'd':
    actionPerformed = player.moveOrAttackRelative(new IVector(1, 0), tileMap);
    break;
  }
  if (actionPerformed) {
    onTurn();
  }
}

void keyReleased() {
}
void keyTyped() {
}
