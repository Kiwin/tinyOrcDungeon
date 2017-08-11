enum Race {
  HUMAN("Human", #ffdbac), ORC("Orc", #79C879);

  //Private Enum Constructor.
  public final String name; 
  public final color skinColor;
  private Race(String name, color skinColor) {
    this.name = name;
    this.skinColor = skinColor;
  }
}
public enum Direction {
  NORTH("North", 0, -1), 
    NORTH_EAST("North-east", 1, -1), 
    NORTH_WEST("North-west", -1, -1), 
    EAST("East", 1, 0), 
    WEST("West", -1, 0), 
    SOUTH("South", 0, 1), 
    SOUTH_EAST("South-east", 1, 1), 
    SOUTH_WEST("South-west", -1, 1);

  public final float x, y;
  public final String name;
  private Direction(String name, int x, int y) {
    this.name = name;
    this.x = x;
    this.y = y;
  }
}
public enum Team {
  Player, Enemy
}