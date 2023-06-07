public abstract class BaseTool extends BaseItem implements Tool {
  
  public final Material primaryMaterial;
  public final Material secondaryMaterial;
  private int durability;
  public BaseTool(String name, Material primaryMaterial, Material secondaryMaterial) {
    super(name);
    this.primaryMaterial = primaryMaterial;
    this.secondaryMaterial = secondaryMaterial;
    this.durability = primaryMaterial.effeciency;
  }
  public boolean isBroken() {
    return this.durability <= 0;
  }
}
