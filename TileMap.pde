public class TileMap {

  public final int width; //Describes the amount of tiles on the horizontal axis.
  public final int height; //Describes the amount of tiles on the vertical axis.
  private Tile[][] tiles; //Two-dimensional array for storing Tile-Objects.

  //Class Constructor
  public TileMap(int width, int height) {
    this.width = width;
    this.height = height;
    tiles = new Tile[width][height];
  }

  //Method that fills the map-array with Tile-Objects.
  public void fillMap(TileType type, boolean solid) {
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        tiles[i][j] = new BaseTile(type, solid);
      }
    }
  }
  public void fillMapEgdes(TileType type, boolean solid) {
    for (int i = 0; i < width; i++) {
      tiles[i][0] = new BaseTile(type, solid);
      tiles[i][height-1] = new BaseTile(type, solid);
    }
    for (int i = 0; i < height; i++) {
      tiles[0][i] = new BaseTile(type, solid);
      tiles[width-1][i] = new BaseTile(type, solid);
    }
  }
  
  public void fillMapTiled(TileType type1, TileType type2) {
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        int typeSwitch = (i+j)%2;
        Tile tile = new BaseTile(typeSwitch==0?type1:type2);
        tile.setColor(GAME.settings.tileColors[typeSwitch+1]);
        tiles[i][j] = tile;
      }
    }
  }

  public Tile getTile(int x, int y) {
    return tiles[x][y];
  }
  public Tile getTile(IVector position) {
    return tiles[position.x][position.y];
  }
  public void setTile(Tile tile, int x, int y){
    tiles[x][y] = tile;
  }
  public void setTile(Tile tile, IVector position){
    tiles[position.x][position.y] = tile;
  }
  public int getTileCount() {
    return this.width * this.height;
  }
  public boolean isPositionInBounds(IVector position) {
    return 0 <= position.x && position.x < width 
        && 0 <= position.y && position.y < height;
  }
}

public class TileMapRenderer {

  public void render(TileMap map, float xOffset, float yOffset, float tileWidth, float tileHeight) {
    for (int i = 0; i < map.width; i++) {
      for (int j = 0; j < map.height; j++) {

        //Select tile
        Tile currentTile = map.getTile(i, j);

        //Calculate tile position
        float tileX = xOffset+i*tileWidth;
        float tileY = yOffset+j*tileHeight;

        //Draw tile
        fill(currentTile.getColor());
        rect(tileX, tileY, tileWidth, tileHeight);
      }
    }
  }
}
