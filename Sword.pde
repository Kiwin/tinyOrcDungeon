public class Sword extends itm_Weapon {
  
  public Sword(Material material_primary, Material material_secondary) {
    super("Sword", material_primary, material_secondary);
  }
  public void draw(float x, float y, float tileWidth, float tileHeight) {
    pushMatrix();
    translate(x, y);
    float swordBladeWidth = tileWidth * 0.05;
    float swordBladeHeight = tileHeight * 0.3;
    float swordParryWidth = tileWidth * 0.15;
    float swordParryHeight = tileHeight * 0.05;
    float swordHandleWidth = tileWidth * 0.05;
    float swordHandleHeight = tileHeight * 0.1;
    
    //Draw blade
    fill(material_secondary.colour);
    rect( -swordBladeWidth / 2, 0, swordBladeWidth, -swordBladeHeight);
    //Draw Parry
    rect( -swordParryWidth / 2, 0, swordParryWidth, swordParryHeight);
    //Draw Handle
    fill(material_primary.colour);
    rect( -swordHandleWidth / 2, swordParryHeight, swordHandleWidth, swordHandleHeight);
    
    popMatrix();
  }
  public void onUse(GameObject caster) {
  }
  
  public String getName() {
    return "Sword";
  }
  
}
