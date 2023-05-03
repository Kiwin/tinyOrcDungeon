public class TileMap {

  public final int width; //Describes the amount of tiles on the horizontal axis. 
  public final int height; //Describes the amount of tiles on the vertical axis.
  protected Tile[][] map; //Two-dimensional array for storing Tile-Objects.

  //Class Constructor 
  public TileMap(int width, int height) {
    this.width = width;
    this.height = height;
    map = new Tile[width][height];
  }

  //Method that fills the map-array with Tile-Objects.
  public void fillMap(int type, boolean solid) {
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        map[i][j] = new Tile(type, solid);
      }
    }
  }
  public void fillMapEgdes(int type, boolean solid) {
    for (int i = 0; i < width; i++) {
      map[i][0] = new Tile(type, solid);
      map[i][height-1] = new Tile(type, solid);
    }
    for (int i = 0; i < height; i++) {
      map[0][i] = new Tile(type, solid);
      map[width-1][i] = new Tile(type, solid);
    }
  }
  public void randomizeMap(int min, int max) {
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        map[i][j] = new Tile(round(random(max-min)+min));
      }
    }
  }
  public void fillMapTiled(int type1, int type2) {

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        map[i][j] = new Tile((i+j)%2==0?type1:type2);
      }
    }
  }
  public Tile getTile(int x, int y) {
    return map[x][y];
  }
}

public class TileMapRenderer {

  public void draw(TileMap map, float xOffset, float yOffset, float tileWidth, float tileHeight, color[] tileColors) {
    for (int i = 0; i < map.width; i++) {
      for (int j = 0; j < map.height; j++) {

        //Select tile
        Tile currentTile = map.getTile(i, j);

        //Calculate tile position
        float tileX = xOffset+i*tileWidth;
        float tileY = yOffset+j*tileHeight;

        //Draw tile
        fill(tileColors[currentTile.type]);
        rect(tileX, tileY, tileWidth, tileHeight);
      }
    }
  }
}
