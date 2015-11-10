public class Slice {
  Integer centerX, centerY;
  Integer r;
  Float startR, stopR;
  Integer c, highc;
  String name;
  Float percentage;

  Slice(Integer centerX, Integer centerY, Integer r, float startR, float stopR, float percentage, String name) {
    this.centerX = centerX;
    this.centerY = centerY;
    this.r       = r;
    this.startR  = startR;
    this.stopR   = stopR;
    this.name    = name;
    this.c = barGraphManager.barGraph.bars.get(0).c;
    setHighC(c);

    this.percentage = percentage;
  }

  public void setHighC(Integer c) {
    Float tintFactor = 0.5f;
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

    arc(centerX, centerY, r, r, startR, stopR, PIE);
  }

  public boolean mouseOver() {

    float distFromCenter = dist(mouseX, mouseY, centerX, centerY);
    if (distFromCenter < r/2) {
      float dx = mouseX - centerX;
      float dy = mouseY - centerY;

      float factor = sqrt((dx*dx) + (dy*dy));
      dx = dx/factor;
      dy = dy/factor;

      float angle = dy > 0 ? acos(dx) : TWO_PI - acos(dx);
      if (angle > startR && angle < stopR) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

