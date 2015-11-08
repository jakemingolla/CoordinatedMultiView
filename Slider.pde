public class Slider {
  
  List<Integer> yearsInOrder;
  Integer x, y, w, h;
  Integer currentX;
  Integer xOffset;
  final Integer SLIDER_COLOR = color(0, 0, 255);
  final Integer SLIDER_R = 10;
  
   Slider(List<Integer> yearsInOrder, Integer x, Integer y, Integer w, Integer h) {
     this.x = x;
     this.y = y;
     this.w = w;
     this.h = h;
     this.yearsInOrder = yearsInOrder;
     println("SIZE = " + yearsInOrder.size());
     xOffset = x + w / (yearsInOrder.size());
     currentX = xOffset;
   }
   
   public void render() {
     pushStyle();
     fill(SLIDER_COLOR);
     stroke(SLIDER_COLOR);
     ellipse(currentX, y, SLIDER_R, SLIDER_R);
     ellipse(currentX, y + h, SLIDER_R, SLIDER_R);
     line(currentX, y, currentX, y + h);
     popStyle();
   }
   
   public Boolean intersect() {
     Float dist1 = sqrt((mouseX - currentX) * (mouseX - currentX) + (mouseY - y) * (mouseY - y));
     if (dist1 < SLIDER_R) {
       return true;
     }
     Float dist1 = sqrt((mouseX - currentX) * (mouseX - currentX) + (mouseY - y) * (mouseY - y));
   }
}
