public abstract class BaseWeapon extends BaseTool implements Weapon {
  
  protected final Material secondaryMaterial;
  
  public BaseWeapon(String name, Material primaryMaterial, Material secondaryMaterial) {
    super(name, primaryMaterial, secondaryMaterial);
    this.secondaryMaterial = secondaryMaterial;
  }
  public int getStrength() {
    return this.secondaryMaterial.effeciency;
  }
}
