public class PieChart {

  public Integer x, y, w, h;

  PieChart(Integer x, Integer y, Integer w, Integer h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public void render(List<String> names, List<Float> percentages) {
    Float start = 0.0f;
    Float stop = 0.0f;
    
    pushStyle();
    noFill();
    stroke(0);
    ellipse(x, y, w, h);
    popStyle();

    for (int i = 0; i < names.size (); i++) {
      String name = names.get(i);
      Float percentage = percentages.get(i);
      stop += percentage;
      fill((255.0 * start), (255.0 * start), (255.0 * start));
      arc(x, y, w, h, start * (2 * PI), stop * (2 * PI), PIE);
      start += percentage;
    }
  }
}

