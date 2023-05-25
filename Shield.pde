public class Shield extends BaseShield {
  public Shield(Material material_primary, Material material_secondary) {
    super("Shield", material_primary, material_secondary);
  }
  public void render(float x, float y, float tileWidth, float tileHeight) {
    float shieldWidth = tileWidth * 0.3;
    float shieldHeight = tileHeight * 0.3;
    float shieldKnotWidth = tileWidth * 0.1;
    float shieldKnotHeight = tileHeight * 0.1;
    
    pushMatrix();
    translate(x, y);
    fill(primaryMaterial.colour);
    ellipse( -shieldWidth * 0.5, -shieldHeight * 0.5, shieldWidth, shieldHeight);
    fill(secondaryMaterial.colour);
    ellipse( -shieldKnotWidth * 0.5, -shieldKnotHeight * 0.5, shieldKnotWidth, shieldKnotHeight);
    popMatrix();
  }
  public void onUse(GameObject caster, GameObject target) {
  }
  
  public String getName() {
    return "Shield";
  }
  
}
