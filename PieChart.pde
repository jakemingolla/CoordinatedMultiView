public class PieChart {

  public Integer x, y, w, h;
  List<String> names;
  List<Float> percentages;
  List<Slice> slices;

  PieChart(Integer x, Integer y, Integer w, Integer h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    slices = new ArrayList<Slice>();
  }

  public void update(List<String> names, List<Float> percentages) {
    Float start = 0.0f;
    Float stop = 0.0f;
    slices.clear();
    for (int i = 0; i < names.size (); i++) {
      String name = names.get(i);
      Float percentage = percentages.get(i);
      stop += percentage;

      Slice s = new Slice(x, y, w, start * (2 * PI), stop * (2 * PI), (float)percentage, name); 
      slices.add(s);
      start += percentage;
    }
  }

  public void render(List<String> names, List<Float> percentages) {
    pushStyle();
    noFill();
    stroke(0);
    ellipse(x, y, w, h);
    popStyle();
    for (Slice s : slices) {
      s.render();
    }
  }
}

