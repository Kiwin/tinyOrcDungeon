public abstract class BaseItem implements Item {

  public final String name;
  public boolean face_right;

  public BaseItem(String name) {
    this.name = name;
    face_right = true;
  }
  public abstract void draw(float x, float y, float w, float h);
  public void use(GameObject caster) {
    this.onUse(caster);
  }
  protected abstract void onUse(GameObject caster);
}
