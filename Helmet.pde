public class Helmet extends BaseArmor {

  public Helmet(Material material_primary) {
    super("Helmet", material_primary);
  }
  public void draw(float x, float y, float w, float h) {
    fill(this.material_primary.colour);
    float helmetX = x - w * 0.02;
    float helmetY = y - h * 0.05;
    float helmetW = w * 1.04;
    float helmetH = h * 0.33;
    rect(helmetX, helmetY, helmetW, helmetH);
    //rect(helmetX+helmetW*, helmetY, helmetW, helmetH);
  }
  public void onUse(GameObject caster) {
  }

  public String getName() {
    return "Helmet";
  }
}
