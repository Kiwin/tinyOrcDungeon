public class TileMap {

  public final int width; //Describes the amount of tiles on the horizontal axis. 
  public final int height; //Describes the amount of tiles on the vertical axis.
  protected BaseTile[][] map; //Two-dimensional array for storing Tile-Objects.

  //Class Constructor 
  public TileMap(int width, int height) {
    this.width = width;
    this.height = height;
    map = new BaseTile[width][height];
  }

  //Method that fills the map-array with Tile-Objects.
  public void fillMap(int type, boolean solid) {
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        map[i][j] = new BaseTile(type, solid);
      }
    }
  }
  public void fillMapEgdes(int type, boolean solid) {
    for (int i = 0; i < width; i++) {
      map[i][0] = new BaseTile(type, solid);
      map[i][height-1] = new BaseTile(type, solid);
    }
    for (int i = 0; i < height; i++) {
      map[0][i] = new BaseTile(type, solid);
      map[width-1][i] = new BaseTile(type, solid);
    }
  }
  public void randomizeMap(int min, int max) {
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        map[i][j] = new BaseTile(round(random(max-min)+min));
      }
    }
  }
  public void fillMapTiled(int type1, int type2) {

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        map[i][j] = new BaseTile((i+j)%2==0?type1:type2);
      }
    }
  }
  public BaseTile getTile(int x, int y) {
    return map[x][y];
  }
  public BaseTile getTile(IVector vector) {
    return map[vector.x][vector.y];
  }
  
  public int getTileCount(){
    return this.width * this.height;
  }
}

public class TileMapRenderer {

  public void render(TileMap map, float xOffset, float yOffset, float tileWidth, float tileHeight, color[] tileColors) {
    for (int i = 0; i < map.width; i++) {
      for (int j = 0; j < map.height; j++) {

        //Select tile
        BaseTile currentTile = map.getTile(i, j);

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
