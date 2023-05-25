public abstract class BaseArmor extends BaseItem implements Armor {

  private int durability;
  public final Material material;
  public BaseArmor(String name, Material material) {
    super(name);
    this.material = material;
    this.durability = material.effeciency;
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
