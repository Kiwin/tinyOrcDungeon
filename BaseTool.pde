public abstract class BaseTool extends BaseItem implements Tool {
  
  public final Material material_primary;
  public final Material material_secondary;
  protected int durability;
  public BaseTool(String name, Material material_primary, Material material_secondary) {
    super(name);
    this.material_primary = material_primary;
    this.material_secondary = material_secondary;
    this.durability = material_primary.effeciency;
  }
  public boolean isBroken() {
    return this.durability <= 0;
  }
}
