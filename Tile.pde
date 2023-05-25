//Simple class representing a tile.
public class BaseTile {

  public int type;
  public boolean solid;

  public BaseTile(int type) {
    this.type = type;
    solid = false;
  }

  public BaseTile(int type, boolean solid) {
    this.type = type;
    this.solid = solid;
  }

  public void onTurn() {
  }
  
  public boolean isSolid(){
    return this.solid;
  }
}

public interface Tile {
  TileType getType();
}

public enum TileType {
  REGULAR
}
