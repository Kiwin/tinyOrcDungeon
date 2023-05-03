public abstract class itm_Weapon extends BaseTool implements Weapon {
  
  protected final Material material_secondary;
  
  public itm_Weapon(String name, Material material_primary, Material material_secondary) {
    super(name, material_primary, material_secondary);
    this.material_secondary = material_secondary;
  }
  public int getStrength() {
    return this.material_secondary.effeciency;
  }
}
