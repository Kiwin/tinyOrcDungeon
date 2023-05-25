
class IVector {

  public int x;
  public int y;

  public IVector() {
    this.x = 0;
    this.y = 0;
  }
  public IVector(int x, int y) {
    this.x = x;
    this.y = y;
  }
  public IVector copy() {
    return new IVector(this.x, this.y);
  }
  public IVector add(IVector other) {
    this.x += other.x;
    this.y += other.y;
    return this;
  }
  public IVector sub(IVector other) {
    this.x -= other.x;
    this.y -= other.y;
    return this;
  }
  public IVector mult(IVector other) {
    this.x *= other.x;
    this.y *= other.y;
    return this;
  }
  public IVector div(IVector other) {
    this.x /= other.x;
    this.y /= other.y;
    return this;
  }
  public IVector multScalar(int scalar) {
    this.x *= scalar;
    this.y *= scalar;
    return this;
  }
  public IVector divScalar(int scalar) {
    this.x /= scalar;
    this.y /= scalar;
    return this;
  }
  public PVector toPVector() {
    return new PVector(this.x, this.y);
  }
  public boolean equals(IVector other) {
    return this.x == other.x && this.y == other.y;
  }
}
