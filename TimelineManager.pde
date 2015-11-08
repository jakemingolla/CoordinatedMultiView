public class TimelineManager {
  
  public Integer x, y, w, h;
  public DataManager dataManager;
  Integer lowerBound;
  Integer upperBound;
  Integer margin;
  
  Slider leftSlider;
  Slider rightSlider;
  
  TimelineManager(DataManager dataManager, Integer x, Integer y, Integer w, Integer h) {
    this.dataManager = dataManager;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    lowerBound = -1;
    upperBound = -1;
    margin = 15;
    
    leftSlider = null;
    rightSlider = new Slider(dataManager.getYearsInOrder(), x, y, w, h);
  }
  
  public void render() {
    rightSlider.render();
    
    pushStyle();
    fill(0, 0, 255);
    List<Integer> yearsInOrder = dataManager.getYearsInOrder();
    Integer xOffset = w / yearsInOrder.size();
    Integer year;
    for (Integer i = 0; i < yearsInOrder.size(); i++) {
      year = yearsInOrder.get(i);
      pushMatrix();
      translate(x + xOffset * i - margin, y + h + margin);
      rotate(PI / 4.0f);
      text(year, 0, 0);
      popMatrix();
    }
    popStyle();
  }
}

