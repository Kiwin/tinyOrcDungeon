/***
 If you are wondering why i am using class names like gObj_Player, which is not correct 
 following java best practice syntax (All class-names should start with capital letter),
 it is because i can't figure out how to make inner-classes in processing.
 Else i would have went with GameObject.Player or something like that.
 ***/

//Meta fields
public boolean GAMEOVER;
public boolean VICTORY;


//Mapping fields
public final int mapWidth = 9, mapHeight = 9;
public final float marginPercent = 0.2;
public final color[] tileColors = new color[] {0, 128, 100}; //{0, #ff6666, #66ff66, #6666ff, #ffff66, #66ffff};
public GraphicalTileMap map;

//Turn-based fields
public int turnCount;

//Render fields
public float x, y, w, h; //x:mapOffsetX, y:mapOffsetY, w:mapDisplayWidth, h:mapDisplayHeight
public float tileWidth; //Variable that describes the width of a tile;
public float tileHeight; //Variable that describes the height of a tile;

//Entity fields
public gObj_Player player;
public GameObjectHandler objects;

//Method that pre-processes stuff, setting settings and such.
public void setup() {
  //Settings
  size(800, 800);
  smooth(12);
  //Initialize.
  init();
}

//Method that initializes the map, objects and ect.
public void init() {
  //Variables
  calculateDisplayVariables();
  turnCount = 0;
  GAMEOVER = false;
  VICTORY = false;
  //Map
  map = new GraphicalTileMap(mapWidth, mapHeight);
  //map.randomizeMap(1, tileColors.length-1);
  map.fillMapTiled(1, 2);
  map.fillMapEgdes(0, true);

  //Entities
  objects = new GameObjectHandler();
  player = new gObj_Player(1, 1);
  objects.add(player);
  for (int i = 0; i < 15; i++) {
    IVector position = new IVector();
    do {
      position.x = round(random(0, mapWidth-1));
      position.y = round(random(0, mapHeight-1));
    } while (tileIsOccupied(position));
    objects.add(new gObj_Orc(position.x, position.y));
  }
}

//Method that calculates where to display the map in the screen.
public void calculateDisplayVariables() {
  float smallestDimension = min(width, height);
  /***
   Here we are creating a margin effect for the displayed map
   by scaling down the map display area accordingly to the 'marginPercent' variable,
   and afterwards calculating the offsets accordingly to the map display dimensions. 
   ***/
  w = smallestDimension*(1-marginPercent);
  h = w;
  x = (width-w)/2;
  y = (height-h)/2;

  float tileSize = min(w/mapWidth, h/mapHeight);
  tileWidth = tileSize;
  tileHeight = tileSize;

  stroke(0);
  strokeWeight(min(tileWidth, tileHeight)*0.014);
}
//returns if the tile value is in range of the map-dimensions.
public boolean tileIsValid(IVector tilePosition) {
  return tilePosition.x >= 0 && tilePosition.x < mapWidth && tilePosition.y >= 0 && tilePosition.y < mapHeight;
}
//Method that return if a tile is occupied by either an object or a solid tile.
public boolean tileIsOccupied(IVector tilePosition) {
  return tileIsOccupiedBySolid(tilePosition) || tileIsOccupiedByObject(tilePosition);
}
//Method that return if a tile is occupied by a solid tile.
public boolean tileIsOccupiedBySolid(IVector tilePosition) {
  return tileIsValid(tilePosition) && map.getTile(tilePosition.x, tilePosition.y).isSolid == true;
}
//Method that return if a tile is occupied by an object.
public boolean tileIsOccupiedByObject(IVector tilePosition) {
  if (tileIsValid(tilePosition))
  {
    for (GameObject obj : objects) {
      if (obj.position.isEqualTo(tilePosition)) {
        return true;
      }
    }
  }
  return false;
}

//Method that draws and updates the map, objects, ect.
public void draw() {  
  //Update
  objects.update();

  //Draw
  map.draw(x, y, tileWidth, tileHeight, tileColors);
  objects.draw(x, y, tileWidth, tileHeight);
  println(frameRate);
}
public void onTurn() {
  if (!GAMEOVER) {
    player.onTurn(turnCount);
    objects.onTurn(turnCount);
    turnCount++;
    if (!player.isAlive()) {
      GAMEOVER = true;
    } else {
      if (objects.size() == 1) {
        VICTORY = true;
      }
    }
  }
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
  //if (keyCode == CODED) {
  // key = char(keyCode);
  //}
  boolean actionPerformed = false;
  switch(key) {
  case 'w':
    actionPerformed = player.moveOrAttack(Direction.NORTH);
    break;
  case 's':
    actionPerformed = player.moveOrAttack(Direction.SOUTH);
    break;
  case 'a':
    actionPerformed = player.moveOrAttack(Direction.WEST);
    break;
  case 'd':
    actionPerformed = player.moveOrAttack(Direction.EAST);
    break;
  case 'n':
    init();
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