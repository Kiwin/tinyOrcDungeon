public class Sword extends BaseWeapon {
  
  public Sword(Material primaryMaterial, Material secondaryMaterial) {
    super("Sword", primaryMaterial, secondaryMaterial);
  }
  public void render(float x, float y, float tileWidth, float tileHeight) {
    pushMatrix();
    translate(x, y);
    float swordBladeWidth = tileWidth * 0.05;
    float swordBladeHeight = tileHeight * 0.3;
    float swordParryWidth = tileWidth * 0.15;
    float swordParryHeight = tileHeight * 0.05;
    float swordHandleWidth = tileWidth * 0.05;
    float swordHandleHeight = tileHeight * 0.1;
    
    //Draw blade
    fill(secondaryMaterial.colour);
    rect( -swordBladeWidth / 2, 0, swordBladeWidth, -swordBladeHeight);
    //Draw Parry
    rect( -swordParryWidth / 2, 0, swordParryWidth, swordParryHeight);
    //Draw Handle
    fill(primaryMaterial.colour);
    rect( -swordHandleWidth / 2, swordParryHeight, swordHandleWidth, swordHandleHeight);
    
    popMatrix();
  }
  public void onUse(GameObject caster, GameObject target) {
  }
  
  public String getName() {
    return "Sword";
  }
  
}
