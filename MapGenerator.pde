import java.util.function.Consumer;

interface MapGenerator {
  TileMap generateMap(int mapWidth, int mapHeight);
}

class RandomWalkMapGeneratorAgent {

  private TileMap map;
  private IVector position;
  private int stepsRemaining;
  private TileType tileType;
  private boolean placeDoorOnCompletion = false;

  RandomWalkMapGeneratorAgent(TileMap map, IVector position, TileType tileType, int steps) {
    this.map = map;
    this.position = position;
    this.tileType = tileType;
    this.stepsRemaining = steps;
  }

  public void shouldPlaceDoorOnCompletion(boolean value) {
    this.placeDoorOnCompletion = value;
  }

  public boolean isDone() {
    return stepsRemaining == 0;
  }

  public void runStep() {
    final IVector[] directions =
      {
      new IVector(1, 0),
      new IVector( -1, 0),
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
    
    if(isDone()){
      onCompletion();
    }
  }

  private void onCompletion() {
    if (placeDoorOnCompletion) {
      GAME.setExitDoorPosition(this.position);
    }
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
    for (int i = 0; i < agentCount; i++) {
      RandomWalkMapGeneratorAgent agent = new RandomWalkMapGeneratorAgent(map, startPosition.copy(), TileType.REGULAR, agentSteps);
      agents.add(agent);
      if (i == 0) {
        agent.shouldPlaceDoorOnCompletion(true);
      }
    }
    for (RandomWalkMapGeneratorAgent agent : agents) {
      while (!agent.isDone()) agent.runStep();
    }

    return map;
  }
}
