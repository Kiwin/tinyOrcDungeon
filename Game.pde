class Game { //<>//
  
  GameSettings settings;
  
  //Entity fields
  Human player;
  final GameObjectHandler objects = new GameObjectHandler();
  
  //Render fields
  float renderWidth;
  float renderHeight;
  float mapOffsetX;
  float mapOffsetY;
  float mapDisplayWidth;
  float mapDisplayHeight;
  float tileWidth; //Variable that describes the width of a tile;
  float tileHeight; //Variable that describes the height of a tile;
  
  public Game(GameSettings settings) {
    this.settings = settings;
  }
  
  public TileMap tileMap;
  final TileMapRenderer mapRenderer = new TileMapRenderer();
  
  //Meta fields
  public boolean GAMEOVER = false;
  public boolean VICTORY = false;
  
  //Game-flow fields
  public int turnCount;
  public void onTurn() {
    if (!GAMEOVER) {
      objects.onTurnBegin(turnCount);
      objects.onTurn(turnCount);
      objects.onTurnEnd(turnCount);
      turnCount++;
      checkForWinCondition();
      checkForGameOverCondition();
    }
    
    //Room exit
    if (player.getPosition().equals(new IVector(settings.mapWidth - 2, settings.mapHeight - 2))) {
      initNewLevel(false, true);
    }
  }
  
  void start() {
    initGame();
  }
  
  void initGame() {
    //Variables
    calculateDisplayVariables();
    turnCount = 0;
    GAMEOVER = false;
    VICTORY = false;
    
    initNewMap();
    initNewLevel(true, true);
  }
  
  void initNewMap() {
    //Map
    tileMap = new TileMap(settings.mapWidth, settings.mapHeight);
    //map.randomizeMap(1, tileColors.length-1);
    tileMap.fillMapTiled(1, 2);
    tileMap.fillMapEgdes(0, true);
  }
  
  void initNewLevel(boolean initNewPlayer, boolean killMobs) {
    if (killMobs) {
      GAME.objects.destroyAllObjects();
    }
    
    if (initNewPlayer) {
      player = new Human(1, 1);
      player.rightHandItem = new Sword(Material.WOOD, Material.WOOD);
      player.leftHandItem = new Axe(Material.WOOD, Material.WOOD);
      player.leftHandItem.isFacingRight = false;
      player.helmet = new Helmet(Material.HELLRITE);
    }
    player.position = new IVector(1, 1);
    objects.addObject(player);
    
    float enemyPerTile = 0.2;
    float enemyPerTileFactor = tileMap.getTileCount() * enemyPerTile;
    float enemyCount = floor(enemyPerTileFactor / 2 + random(enemyPerTileFactor / 4));
    println("Spawning", enemyCount, "enemies");
    
    for (int i = 0; i < enemyCount; i++) {
      
      IVector position = new IVector();
      int triesRemaining = 10;
      do {
        position.x = round(random(0, settings.mapWidth - 1));
        position.y = round(random(0, settings.mapHeight - 1));
        triesRemaining--;
        println("attempting to spawn enemy at", position.x, position.y, triesRemaining);
      } while(triesRemaining > 0 && tileIsOccupied(position, tileMap, objects));
      objects.addObject(new OrcEntity(position.x, position.y));
      if (triesRemaining > 0) {
        println("Enemy spawned", position.x, position.y, triesRemaining);
      } else {
        println("Failed to spawn enemy");
      }
      println("Enemies left to spawn:", enemyCount - i - 1);
    }
    
    checkForWinCondition();
  }
  
  //Method that calculates where to display the map in the screen.
  void calculateDisplayVariables() {
    float renderWidth = width;
    float renderHeight = height;
    
    float smallestDimension = min(renderWidth, renderHeight);
    /***
    Here we are creating a margin effect for the displayed map
    by scaling down the map display area accordingly to the 'marginPercent' variable,
    and afterwards calculating the offsets accordingly to the map display dimensions.
    ***/
    mapDisplayWidth = smallestDimension * (1 - (settings.viewportBorderMarginPercent * 0.01));
    mapDisplayHeight = mapDisplayWidth;
    mapOffsetX = (renderWidth - mapDisplayWidth) / 2;
    mapOffsetY = (renderHeight - mapDisplayHeight) / 2;
    
    float tileSize = min(mapDisplayWidth / settings.mapWidth, mapDisplayHeight / settings.mapHeight);
    tileWidth = tileSize;
    tileHeight = tileSize;
  }
  
  void checkForGameOverCondition() {
    GAMEOVER = !player.isAlive();
  }
  
  void checkForWinCondition() {
    VICTORY = objects.getObjectCount() == 1;
  }
  
  
  void update() {
    objects.update();
  }
  void render() {
    background(64);
    mapRenderer.render(tileMap, mapOffsetX, mapOffsetY, tileWidth, tileHeight, settings.tileColors);
    drawExitDoor();
    objects.render(mapOffsetX, mapOffsetY, tileWidth, tileHeight);
    drawHealthBar(tileWidth * 0.2, tileHeight * 0.2, tileWidth * 0.8, tileHeight * 0.8);
  }
  
  void drawExitDoor() {
    fill(#984310);
    noStroke();
    rect((settings.mapWidth - 2) * tileWidth + mapOffsetX,(settings.mapHeight - 2) * tileHeight + mapOffsetY, tileWidth, tileHeight);
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
  
  public void onKeyPressed(char key) {
    switch(key) {
      case 'n':
        initGame();
        break;
    }
    if (GAMEOVER) return;
    handlePlayerAction(key);
  }
  
  public void handlePlayerAction(char key) {
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
}
