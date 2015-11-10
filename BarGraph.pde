public class BarGraph {
  Integer x, y, w, h;
  List<Bar> bars;
  Integer margin;
  Integer offset;
  Float offsetFactor;
  // For coloring
  RibbonManager ribbonManager;
  Integer maxY;
  Integer currentC;

  BarGraph(RibbonManager ribbonManager, Integer x, Integer y, Integer w, Integer h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.bars = new ArrayList<Bar>();
    offsetFactor = 0.5;
    offset = -1;

    this.ribbonManager = ribbonManager;

    this.margin = int(min(h, w) * .1);


    //instantiate the bars
  }

  public void update(List<Data> data) {
    bars.clear();
    Integer max = -1;
    Integer count = data.size();
    for (Data d : data) {
      if (d.funding > max) {
        max = d.funding;
      }
    }

    println("max = " + max);


    offset = (int)(((w - 2 * margin) / count) * offsetFactor);
    //    Integer barWidth = (int)((w - 2 * margin / count) - offset);
    Integer barWidth = ((w - 2*margin) / count)-offset;

    int i;
    for (i = 0; i < count; i++) {
      Data d = data.get(i);
      Integer barHeight = (int)((h - 2*margin) * (float)d.funding / (float)max);
      Bar bar = new Bar(d.discipline, d.department, d.funding, (x + margin) + offset/2 + (offset+barWidth) * i, y + h - margin - barHeight, barWidth, barHeight);
      bar.setC(ribbonManager.getColorByDisciplineAndDepartment(d.discipline, d.department));
      bars.add(bar);
    }
  }


  public void render() {
    drawAxes();
    for (Bar b : bars) {
      b.render();
    }
    makeToolTip();
  }

  public void makeToolTip() {
    for (Bar b : bars) {
      if (b.mouseOver()) {
        pushStyle();
        fill(0);
        stroke(0);
        text(DEPARTMENT + ": " +b.department + "\n" + TOTAL + ": " + b.funding, mouseX, mouseY - 20);
        popStyle();
      }
    }
  }

  public void drawAxes() {
    pushStyle();
    pushMatrix();
    fill(0);
    strokeWeight(1);
    // Title
    String currentDiscipline = bars.get(0).discipline;
    if (currentDiscipline != null) {
      text(TOTAL + " by " + DEPARTMENT + " in " + currentDiscipline, x + (w / 2) - (8 * currentDiscipline.length()), y + (margin / 2) );
    }
    //x axis
    line(x + margin, y + h - margin, x + w - margin, y + h - margin);
    text(DEPARTMENT, x + (w / 2) - margin, y + h - (margin / 2));
    //y axis
    line(x + margin, y + h - margin, x + margin, y + margin);
    translate(x + (margin / 2) + 1 + 1 + 1 + 1, y + (5* h / 7) - margin);
    rotate(3 * PI / 2);
    text(TOTAL, 0, 0);
    popMatrix();
    popStyle();
  }
}

