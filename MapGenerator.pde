interface MapGenerator {
  TileMap generateMap(int mapWidth, int mapHeight);
}

class RandomWalkMapGeneratorAgent {

  TileMap map;
  IVector position;
  int stepsRemaining;
  TileType tileType;

  RandomWalkMapGeneratorAgent(TileMap map, IVector position, TileType tileType, int steps) {
    this.map = map;
    this.position = position;
    this.tileType = tileType;
    this.stepsRemaining = steps;
  }

  public boolean isDone() {
    return stepsRemaining == 0;
  }

  public void runStep() {
    final IVector[] directions =
      {
      new IVector(1, 0),
      new IVector(-1, 0),
      new IVector(0, 1),
      new IVector(0, -1),
    };

    IVector randomDirection;

    do {
      int rnd = floor(random(directions.length));
      println(rnd);
      randomDirection = directions[rnd];
    } while (!map.isPositionInBounds(position.copy().add(randomDirection)));

    position.add(randomDirection);
    Tile tile = new BaseTile(tileType, false);
    tile.setColor(GAME.settings.tileColors[1]);
    map.setTile(tile, position);
    stepsRemaining--;
  }
}

class RandomWalkMapGenerator implements MapGenerator {

  final int agentSteps = 50;
  final int agentCount = 3;
  TileMap map;

  RandomWalkMapGenerator() {
  }

  RandomWalkMapGenerator(TileMap existingMap) {
    this.map = existingMap;
  }

  TileMap generateMap(int mapWidth, int mapHeight) {
    if (map == null) {
      map = new TileMap(mapWidth, mapHeight);
      map.fillMap(TileType.REGULAR, true);
    }

    final IVector startPosition = new IVector(1, 1);
    map.setTile(new BaseTile(TileType.REGULAR, false), startPosition.copy());

    ArrayList<RandomWalkMapGeneratorAgent> agents = new ArrayList<RandomWalkMapGeneratorAgent>();
    for (int i = 0; i < agentCount; i++) agents.add(new RandomWalkMapGeneratorAgent(map, startPosition.copy(), TileType.REGULAR, agentSteps));

    for (RandomWalkMapGeneratorAgent agent : agents) {
      while (!agent.isDone()) agent.runStep();
    }

    return map;
  }
}
