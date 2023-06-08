import java.util.Comparator;
import java.util.Collections;

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
  public IVector add(int x, int y){
    this.x += x;
    this.y += y;
    return this;
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
  public IVector sub(int x, int y){
    this.x -= x;
    this.y -= y;
    return this;
  }
  public IVector mult(IVector other) {
    this.x *= other.x;
    this.y *= other.y;
    return this;
  }
  public IVector mult(int scalar) {
    this.x *= scalar;
    this.y *= scalar;
    return this;
  }
  public IVector div(IVector other) {
    this.x /= other.x;
    this.y /= other.y;
    return this;
  }
  public IVector div(int scalar) {
    this.x /= scalar;
    this.y /= scalar;
    return this;
  }
  public PVector toPVector() {
    return new PVector(this.x, this.y);
  }
  public float distanceTo(IVector other) {
    return dist(this.x, this.y, other.x, other.y);
  }
  public boolean equals(IVector other) {
    return this.x == other.x && this.y == other.y;
  }
}

static class CompareIVectorByDistance implements Comparator<IVector[]> {
  public int compare(IVector[] a, IVector[] b) {
    float aDist = a[0].distanceTo(a[1]);
    float bDist = b[0].distanceTo(b[1]);
    return Float.compare(aDist, bDist);
  }
}

static class IVectorHelper {

  public static ArrayList<IVector> sortByDistance(ArrayList<IVector> vectors, IVector target) {

    //Create Position Target Pairs
    ArrayList<IVector[]> vectorsTargetPairs = new ArrayList<IVector[]>();
    for (IVector vector : vectors) {
      vectorsTargetPairs.add(new IVector[]{vector, target});
    }

    //Sort by distance from Position to Target.
    Collections.sort(vectorsTargetPairs, new CompareIVectorByDistance());

    //Convert sorted pairs to Position list.
    ArrayList<IVector> vectorsSorted = new ArrayList<IVector>();
    for (IVector[] vectorTargetPair : vectorsTargetPairs) {
      vectorsSorted.add(vectorTargetPair[0]);
    }
    
    return vectorsSorted;
  }
}
