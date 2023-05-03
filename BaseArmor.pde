public abstract class BaseArmor extends BaseItem implements Armor {
  private int durability;
  public final Material material_primary;
  public BaseArmor(String name, Material material_primary) {
    super(name);
    this.material_primary = material_primary;
    this.durability = material_primary.effeciency;
  }
  public boolean isBroken() {
    return this.durability <= 0;
  }
  public int getArmor() {
    return this.durability;
  }
  
  public int blockDamage(int damage) {
    if (!this.isBroken()) {
      if (damage >= this.durability) {
        this.durability = 0;
        return damage - this.durability;
      } else {
        this.durability -= damage;
        return 0;
      }
    }
    return damage;
  }
}
