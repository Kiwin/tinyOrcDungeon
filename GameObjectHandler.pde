public class GameObjectHandler {


  final ArrayList<GameObject> objects = new ArrayList<GameObject>();

  //Class Constructor.
  public GameObjectHandler() {
  }

  public int getObjectCount() {
    return objects.size();
  }

  public ArrayList<GameObject> getObjects() {
    return objects;
  }

  public void addObject(GameObject obj) {
    objects.add(obj);
  }

  public void destroyAllObjects() {
    objects.clear();
  }

  //Method that updates all objects in the list.
  public void update() {
    for (GameObject obj : objects) {
      obj.update();
    }
  }

  //Method that deletes all dead objects from the list.
  //It also calls the objects onDeath() method before deleting it.
  public void garbageCollect() {
    /***
     The for-loop loops through the object list backwards to avoid
     error from the elements inside the list shuffling around when trying to access them..
     ***/
    for (int i = objects.size()-1; i >= 0; i--) {
      GameObject obj = objects.get(i);
      if (!obj.isAlive() && obj.deleteable) {
        obj.onDeath();
        objects.remove(obj);
      }
    }
  }

  //Method that draws all objects in the list.
  public void render(float xOffset, float yOffset, float tileWidth, float tileHeight) {
    for (GameObject obj : objects) {
      obj.render(xOffset, yOffset, tileWidth, tileHeight);
    }
  }
  //Method that calls all objects in the lists onTurn method.
  public void onTurnBegin(int turnCount) {
    for (GameObject obj : objects) {
      obj.onTurnBegin(turnCount);
    }
    garbageCollect();
  }
  public void onTurn(int turnCount) {
    for (GameObject obj : objects) {
      obj.onTurn(turnCount);
    }
    garbageCollect();
  }
  public void onTurnEnd(int turnCount) {
    for (GameObject obj : objects) {
      obj.onTurnEnd(turnCount);
    }
    garbageCollect();
  }

  //Tries to return the GameObject at given position
  //If no GameObject is found it will return null
  public GameObject getObjectAt(IVector position) {
    for (GameObject obj : objects) {
      if (obj.position.equals(position)) {
        return obj;
      }
    }
    return null;
  }
}
