
//returns if the tile value is in range of the map-dimensions.
static boolean tileIsInBounds(IVector tilePosition, TileMap tileMap) {
  return tilePosition.x >= 0 && tilePosition.x < tileMap.width && tilePosition.y >= 0 && tilePosition.y < tileMap.height;
}

//Method that return if a tile is occupied by either an object or a solid tile.
static boolean tileIsOccupied(IVector tilePosition, TileMap tileMap, GameObjectHandler objects) {
  return tileMap.getTile(tilePosition).isSolid() || objects.getObjectAt(tilePosition) != null;
}
