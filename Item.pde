interface Weapon {
 
  int getStrength();
  
}

interface Item {

  String getName();
  void use(GameObject user);
}




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

public abstract class BaseShield extends BaseTool {
  public BaseShield(String name, Material material_primary, Material material_secondary) {
    super(name, material_primary, material_secondary);
  }
}

interface Tool {
  
  boolean isBroken();
  
}

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

interface Armor {

  public int getArmor();
  public boolean isBroken();
  public int blockDamage(int damage);
}

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

public class Helmet extends BaseArmor {
  public Helmet(Material material_primary) {
    super("Helmet", material_primary);
  }
  public void draw(float x, float y, float w, float h) {
    fill(this.material_primary.colour);
    float helmetX = x-w*0.02;
    float helmetY = y-h*0.05;
    float helmetW = w*1.04;
    float helmetH = h*0.33;
    rect(helmetX, helmetY, helmetW, helmetH);
    //rect(helmetX+helmetW*, helmetY, helmetW, helmetH);
  }
  public void onUse(GameObject caster) {
  }
  
  public String getName(){
    return "Helmet";
  }
}
public class Chestplate extends BaseArmor {

  public Chestplate(Material material_primary) {
    super("Chestplate", material_primary);
  }
  public void draw(float x, float y, float w, float h) {
  }
  public void onUse(GameObject caster) {
  }
  public String getName(){
    return "Chestplate";
  }
}

public class Sword extends itm_Weapon {

  public Sword(Material material_primary, Material material_secondary) {
    super("Sword", material_primary, material_secondary);
  }
  public void draw(float x, float y, float tileWidth, float tileHeight) {
    pushMatrix();
    translate(x, y);
    float swordBladeWidth = tileWidth*0.05;
    float swordBladeHeight = tileHeight*0.3;
    float swordParryWidth = tileWidth*0.15;
    float swordParryHeight = tileHeight*0.05;
    float swordHandleWidth = tileWidth*0.05;
    float swordHandleHeight = tileHeight*0.1;

    //Draw blade
    fill(material_secondary.colour);
    rect(-swordBladeWidth/2, 0, swordBladeWidth, -swordBladeHeight);
    //Draw Parry
    rect(-swordParryWidth/2, 0, swordParryWidth, swordParryHeight);
    //Draw Handle
    fill(material_primary.colour);
    rect(-swordHandleWidth/2, swordParryHeight, swordHandleWidth, swordHandleHeight);

    popMatrix();
  }
  public void onUse(GameObject caster) {
  }
  
  public String getName(){
    return "Sword";
  }
  
}
public class Axe extends itm_Weapon {

  public Axe(Material material_primary, Material material_secondary) {
    super("Axe", material_primary, material_secondary);
  }
  public void draw(float x, float y, float tileWidth, float tileHeight) {
    float axeHandleWidth = tileWidth*0.05;
    float axeHandleHeight = tileHeight*0.3;
    float axeHeadWidth = tileWidth*0.1;
    float axeHeadHeight = tileHeight*0.15;


    pushMatrix();
    translate(x, y);
    if (!face_right) {
      scale(-1, 1);
    }
    //Draw Handle
    fill(material_primary.colour);
    rect(-axeHandleWidth/2, -axeHandleHeight/3, axeHandleWidth, axeHandleHeight);
    //Draw Head
    fill(material_secondary.colour);
    beginShape();
    vertex(0, -axeHandleHeight/3);
    vertex(axeHeadWidth, axeHeadHeight-axeHandleHeight/3);
    vertex(axeHeadWidth, -axeHandleHeight/3);
    endShape(CLOSE);

    popMatrix();
  }
  public void onUse(GameObject caster) {
  }
  
  public String getName(){
    return "Axe";
  }
}

public class Shield extends BaseShield {
  public Shield(Material material_primary, Material material_secondary) {
    super("Shield", material_primary, material_secondary);
  }
  public void draw(float x, float y, float tileWidth, float tileHeight) {
    float shieldWidth = tileWidth*0.3;
    float shieldHeight = tileHeight*0.3;
    float shieldKnotWidth = tileWidth*0.1;
    float shieldKnotHeight = tileHeight*0.1;

    pushMatrix();
    translate(x, y);
    fill(material_primary.colour);
    ellipse(-shieldWidth*0.5, -shieldHeight*0.5, shieldWidth, shieldHeight);
    fill(material_secondary.colour);
    ellipse(-shieldKnotWidth*0.5, -shieldKnotHeight*0.5, shieldKnotWidth, shieldKnotHeight);
    popMatrix();
  }
  public void onUse(GameObject caster) {
  }
  
  public String getName(){
    return "Shield";
  }
  
}
