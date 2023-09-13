//Simple class representing a tile.
public class BaseTile implements Tile {

  public TileType type;
  public boolean solid;
  private color tileColor;

  public BaseTile(TileType type) {
    this.type = type;
    solid = false;
  }

  public BaseTile(TileType type, boolean solid) {
    this.type = type;
    this.solid = solid;
  }

  TileType getType() {
    return this.type;
  }

  public void onTurn() {
  }

  public boolean isSolid() {
    return this.solid;
  }
  public color getColor() {
    return this.tileColor;
  }
  public void setColor(color tileColor){
    this.tileColor = tileColor;
  }
}

public interface Tile {
  //IVector getPosition();
  TileType getType();
  boolean isSolid();
  color getColor();
  void setColor(color tileColor);
}

public enum TileType {
  REGULAR
}
