public enum Material {
  WOOD("Wood", 1, #663300), 
    IRON("Iron", 2, #999999), 
    COBALT("Cobalt", 3, #6666ff),
    HELLRITE("Hellrite", 4, #ff6666);

  public final String name;
  public final color colour;
  public final int effeciency;

  private Material(String name, int effeciency, color colour) {
    this.name = name;
    this.effeciency = effeciency;
    this.colour = colour;
  }
}
