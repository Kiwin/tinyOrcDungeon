public abstract class Item {

  public final String name;
  public boolean face_right;

  public Item(String name) {
    this.name = name;
    face_right = true;
  }

  public abstract void draw(float x, float y, float tileWidth, float tileHeight);
}

public abstract class itm_Shield extends Item {
  public final int armor;
  public itm_Shield(String name, int arm) {
    super(name);
    this.armor = arm;
  }
}
public abstract class itm_Armor extends Item {
  public final int armor;
  public itm_Armor(String name, int arm) {
    super(name);
    this.armor = arm;
  }
}
public abstract class itm_Weapon extends Item {
  public final int damage;
  public itm_Weapon(String name, int dmg) {
    super(name);
    this.damage = dmg;
  }
}

public abstract class arm_Helmet extends itm_Armor {
  public arm_Helmet(String name, int arm) {
    super(name, arm);
  }
}
public abstract class arm_Chestplate extends itm_Armor {

  public arm_Chestplate(String name, int arm) {
    super(name, arm);
  }
}

public class wep_Sword extends itm_Weapon {

  public wep_Sword() {
    super("Sword", 1);
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
    fill(128);
    rect(-swordBladeWidth/2, 0, swordBladeWidth, -swordBladeHeight);
    //Draw Parry
    rect(-swordParryWidth/2, 0, swordParryWidth, swordParryHeight);
    //Draw Handle
    fill(#663300);
    rect(-swordHandleWidth/2, swordParryHeight, swordHandleWidth, swordHandleHeight);

    popMatrix();
  }
}
public class wep_Axe extends itm_Weapon {

  public wep_Axe() {
    super("Axe", 1);
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
    fill(#663300);
    rect(-axeHandleWidth/2, -axeHandleHeight/3, axeHandleWidth, axeHandleHeight);
    //Draw Head
    fill(128);
    beginShape();
    vertex(0, -axeHandleHeight/3);
    vertex(axeHeadWidth, axeHeadHeight-axeHandleHeight/3);
    vertex(axeHeadWidth, -axeHandleHeight/3);
    endShape(CLOSE);

    popMatrix();
  }
}

public class shd_Shield extends itm_Shield {
  public shd_Shield() {
    super("Shield", 1);
  }
  public void draw(float x, float y, float tileWidth, float tileHeight) {
    float shieldWidth = tileWidth*0.3;
    float shieldHeight = tileHeight*0.3;
    float shieldKnotWidth = tileWidth*0.1;
    float shieldKnotHeight = tileHeight*0.1;

    pushMatrix();
    translate(x, y);
    fill(#663300);
    ellipse(-shieldWidth*0.5, -shieldHeight*0.5, shieldWidth, shieldHeight);
    fill(128);
    ellipse(-shieldKnotWidth*0.5, -shieldKnotHeight*0.5, shieldKnotWidth, shieldKnotHeight);
    popMatrix();
  }
}