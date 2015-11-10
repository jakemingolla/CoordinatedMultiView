public class Bar {
  Integer x, y, w, h;
  color c;
  color highc;
  String discipline;
  Integer funding;
  String department;

  Bar(String discipline, String department, Integer funding, Integer x, Integer y, Integer w, Integer h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    this.discipline = discipline;
    this.department = department;
    this.funding = funding;

    this.c = color(random(255), random(255), random(255));
  }


  public void setC(Integer c) {
    Float tintFactor = 0.5f;
    this.c = c;
    int red, green, blue;
    red = (int)red(c);
    red = floor(red + (255-red)*tintFactor);

    green = (int)green(c);
    green = floor(green + (255-green)*tintFactor);

    blue = (int)blue(c);
    blue = floor(blue + (255-blue)*tintFactor);

    highc = color(red, green, blue);
  }

  public void render() {
    if (mouseOver()) {
      fill(highc);
    } else {
      fill(c);
    }
    rect(x, y, w, h);
  }

  public boolean mouseOver() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      return true;
    } else {
      return false;
    }
  }
}

