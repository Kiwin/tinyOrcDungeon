class StatOverlay {

  GameObject object;
  boolean positionRelativeToObject = false;
  Displayable displayableObject;

  public void shouldPositionRelativeToObject(boolean positionRelativeToObject) {
    this.positionRelativeToObject = positionRelativeToObject;
  }

  public StatOverlay(GameObject object, Displayable displayableObject) {
    this.object = object;
    this.displayableObject = displayableObject;
  }

  public void render() {
    PVector position = displayableObject.getDisplayPosition();
    drawHealthBar(position.x, position.y, displayableObject.getDisplayWidth(), displayableObject.getDisplayHeight());
  }

  private void drawHealthBar(float x, float y, float w, float h) {
    float w2 = w * 0.9;
    pushMatrix();
    translate(x, y);

    for (int i = 0; i < object.getHealth(); i++) {
      //Draw Hearts
      float x2 = w2 * i;
      if (i == object.getHealth() - 1 && object.getArmor() == 0) {
        float n = sin(frameCount * 0.1) * 30;
        fill(164 + n, n, n);
      } else {
        fill(#880000);
      }
      beginShape();
      vertex(x2 + w * 0.25, 0);
      vertex(x2 + w * 0.5, h * 0.25);
      vertex(x2 + w * 0.75, 0);
      vertex(x2 + w, h * 0.50);
      vertex(x2 + w * 0.5, h);
      vertex(x2, h * 0.50);
      endShape(CLOSE);
    }

    //Draw Shields
    for (int i = object.getHealth(); i < object.getHealth() + object.getArmor(); i++) {
      float x2 = w2 * i;
      float c = 120 + i * 20;
      if (i == object.getHealth() + object.getArmor() - 1) {
        float n = sin(frameCount * 0.1) * 15;
        c += n;
      }
      fill(c);
      beginShape();
      vertex(x2 + w * 0.5, 0);
      vertex(x2 + 0, h * 0.5);
      vertex(x2 + w * 0.5, h);
      vertex(x2 + w, h * 0.5);
      endShape(CLOSE);
    }
    popMatrix();
  }
}
