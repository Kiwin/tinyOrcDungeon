public abstract class BaseItem implements Item {

  public final String name;
  public boolean isFacingRight;

  public BaseItem(String name) {
    this.name = name;
    isFacingRight = true;
  }
  public abstract void render(float x, float y, float w, float h);
  public void use(GameObject user, GameObject target) {
    this.onUse(user, target);
  }
  public abstract void onUse(GameObject user, GameObject target);
}
