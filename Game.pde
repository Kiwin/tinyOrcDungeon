class Game { //<>//
  
  public GameSettings settings;
  
  //Entity fields
  Human player;
  final GameObjectHandler objectHandler = new GameObjectHandler();
  
  //Render fields
  float renderWidth;
  float renderHeight;
  float mapOffsetX;
  float mapOffsetY;
  float mapDisplayWidth;
  float mapDisplayHeight;
  float tileWidth; //Variable that describes the width of a tile;
  float tileHeight; //Variable that describes the height of a tile;
  ArrayList<StatOverlay> statOverlays = new ArrayList<StatOverlay>();
  
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
      objectHandler.onTurnBegin(turnCount);
      objectHandler.onTurn(turnCount);
      objectHandler.onTurnEnd(turnCount);
      turnCount++;
      checkForWinCondition();
      checkForGameOverCondition();
    }
    
    //Room exit
    if (player.getPosition().equals(new IVector(settings.mapWidth - 2, settings.mapHeight - 2))) {
      initNewLevel(false, true);
    }
  }
  
  public void start() {
    initGame();
  }
  
  private void initGame() {
    //Variables
    calculateDisplayVariables();
    turnCount = 0;
    GAMEOVER = false;
    VICTORY = false;
    
    initNewMap();
    initNewLevel(true, true);
  }
  
  private void initNewMap() {
    RandomWalkMapGenerator generator = new RandomWalkMapGenerator();
    tileMap = generator.generateMap(settings.mapWidth,settings.mapHeight);
    tileMap.fillMapEgdes(TileType.REGULAR, true);
  }
  
  private void initNewLevel(boolean initNewPlayer, boolean killMobs) {
    if (killMobs) {
      GAME.objectHandler.destroyAllObjects();
    }
    
    if (initNewPlayer) {
      player = new Human(1, 1);
      player.rightHandItem = new Sword(Material.WOOD, Material.WOOD);
      player.leftHandItem = new Axe(Material.WOOD, Material.WOOD);
      player.leftHandItem.isFacingRight = false;
      player.helmet = new Helmet(Material.HELLRITE);
      
      StatOverlay playerStatOverlay = new StatOverlay(player, player);
      playerStatOverlay.shouldPositionRelativeToObject(false);
      statOverlays.add(playerStatOverlay);
    }
    player.setPosition(new IVector(1, 1));
    objectHandler.addObject(player);
    
    spawnEnemies(tileMap);
    
    checkForWinCondition();
  }
  
  private void spawnEnemies(TileMap map){
  float enemyPerTile = 0.2;
    float enemyPerTileFactor = tileMap.getTileCount() * enemyPerTile;
    float enemyCount = floor(enemyPerTileFactor / 2 + random(enemyPerTileFactor / 4));
    println("Spawning", enemyCount, "enemies");
    
    for (int i = 0; i < enemyCount; i++) {
      
      IVector position = new IVector();
      int triesRemaining = 10;
      do {
        position.x = round(random(0, map.width - 1));
        position.y = round(random(0, map.height - 1));
        triesRemaining--;
        println("attempting to spawn enemy at", position.x, position.y, triesRemaining);
      } while(triesRemaining > 0 && tileIsOccupied(position, tileMap, objectHandler));
      objectHandler.addObject(new OrcEntity(position.x, position.y));
      if (triesRemaining > 0) {
        println("Enemy spawned", position.x, position.y);
      } else {
        println("Failed to spawn enemy");
      }
      println("Enemies left to spawn:", enemyCount - i - 1);
    }
  }
  
  //Method that calculates where to display the map in the screen.
  private void calculateDisplayVariables() {
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
  
  private void checkForGameOverCondition() {
    GAMEOVER = !player.isAlive();
  }
  
  private void checkForWinCondition() {
    VICTORY = objectHandler.getObjectCount() == 1;
  }
  
  public void update() {
    objectHandler.update();
  }
  public void render() {
    background(64);
    mapRenderer.render(tileMap, mapOffsetX, mapOffsetY, tileWidth, tileHeight);
    drawExitDoor();
    objectHandler.render(mapOffsetX, mapOffsetY, tileWidth, tileHeight);
    
    //GUI
    for(StatOverlay overlay : statOverlays){
      overlay.render();
    }
  }
  
  private void drawExitDoor() {
    fill(#984310);
    noStroke();
    rect((settings.mapWidth - 2) * tileWidth + mapOffsetX,(settings.mapHeight - 2) * tileHeight + mapOffsetY, tileWidth, tileHeight);
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
