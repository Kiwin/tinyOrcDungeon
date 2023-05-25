public class Axe extends BaseWeapon {

  public Axe(Material material_primary, Material material_secondary) {
    super("Axe", material_primary, material_secondary);
  }
  public void render(float x, float y, float tileWidth, float tileHeight) {
    float axeHandleWidth = tileWidth * 0.05;
    float axeHandleHeight = tileHeight * 0.3;
    float axeHeadWidth = tileWidth * 0.1;
    float axeHeadHeight = tileHeight * 0.15;


    pushMatrix();
    translate(x, y);
    if (!isFacingRight) {
      scale( -1, 1);
    }
    //Draw Handle
    fill(primaryMaterial.colour);
    rect( -axeHandleWidth / 2, -axeHandleHeight / 3, axeHandleWidth, axeHandleHeight);
    //Draw Head
    fill(secondaryMaterial.colour);
    beginShape();
    vertex(0, -axeHandleHeight / 3);
    vertex(axeHeadWidth, axeHeadHeight - axeHandleHeight / 3);
    vertex(axeHeadWidth, -axeHandleHeight / 3);
    endShape(CLOSE);

    popMatrix();
  }
  public void onUse(GameObject user, GameObject target) {
  }

  public String getName() {
    return "Axe";
  }
}
