public class Slider {

  List<Integer> yearsInOrder;
  Integer x, y, w, h;
  Integer currentX;
  Integer xOffset;
  final Integer SLIDER_COLOR = color(0, 0, 255);
  final Integer SLIDER_R = 10;
  Boolean dragging;
  Integer currentIndex;
  Boolean current;

  Slider(List<Integer> yearsInOrder, Integer x, Integer y, Integer w, Integer h, Integer startingIndex, Integer intersectOffset) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.yearsInOrder = yearsInOrder;
    xOffset = w / (yearsInOrder.size() - 1);
    currentIndex = startingIndex;
    currentX = x + startingIndex * xOffset + intersectOffset;
    dragging = false;
    current = false;
  }

  public void render() {
    pushStyle();
    fill(SLIDER_COLOR);
    stroke(SLIDER_COLOR);
    if (current) {
      strokeWeight(10);
    }
    ellipse(currentX, y, SLIDER_R, SLIDER_R);
    ellipse(currentX, y + h, SLIDER_R, SLIDER_R);
    line(currentX, y, currentX, y + h);
    popStyle();
  }

  public void update() {
    if (!mousePressed) {
      dragging = false;
    }
    if ((dragging) || (mousePressed && intersect())) {
      dragging = true;
      if (mouseX > x && mouseX < currentX - (xOffset / 2)) {
        currentX -= xOffset;
        currentIndex--;
      } else if (mouseX < (x + w) && mouseX > currentX + (xOffset / 2)) {
        currentX += xOffset;
        currentIndex++;
      }
    }
  }

  public void goLeft() {
    if (currentIndex > 0) {
      currentIndex --;
      currentX -= xOffset;
    }
  }

  public void goRight() {
    if (currentIndex < yearsInOrder.size() - 1) {
      currentIndex ++;
      currentX += xOffset;
    }
  }

  public Boolean intersect() {
    if ((mouseX < currentX + SLIDER_R && mouseX > currentX - SLIDER_R) &&
      (mouseY < y + (h * 1.10) && mouseY > (y - (h * 0.10)))) {
      return true;
    } else {
      return false;
    }
  }

  public Integer getYear() {
    return yearsInOrder.get(currentIndex);
  }
}

