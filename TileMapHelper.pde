
//returns if the tile value is in range of the map-dimensions.
boolean tileIsInBounds(IVector tilePosition, TileMap tileMap) {
  return tilePosition.x >= 0 && tilePosition.x < tileMap.width && tilePosition.y >= 0 && tilePosition.y < tileMap.height;
}

//Method that return if a tile is occupied by either an object or a solid tile.
boolean tileIsOccupied(IVector tilePosition, TileMap tileMap) {
  return tileIsOccupiedBySolid(tilePosition, tileMap) || tileIsOccupiedByObject(tilePosition, tileMap);
}

//Method that return if a tile is occupied by a solid tile.
boolean tileIsOccupiedBySolid(IVector tilePosition, TileMap tileMap) {
  return tileIsInBounds(tilePosition,tileMap) && tileMap.getTile(tilePosition.x, tilePosition.y).isSolid;
}

//Method that return if a tile is occupied by an object.
boolean tileIsOccupiedByObject(IVector tilePosition, TileMap tileMap) {
  if (tileIsInBounds(tilePosition,tileMap))
  {
    for (GameObject obj : GAME.objects) {
      if (obj.position.isEqualTo(tilePosition)) {
        return true;
      }
    }
  }
  return false;
}
