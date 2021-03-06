public class TimelineManager {

  public Integer x, y, w, h;
  public DataManager dataManager;
  Integer lowerBound;
  Integer upperBound;
  Integer margin;

  Slider leftSlider;
  Slider rightSlider;
  public Slider currentSlider;

  RibbonManager ribbonManager;

  TimelineManager(DataManager dataManager, Integer x, Integer y, Integer w, Integer h) {
    this.dataManager = dataManager;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    lowerBound = -1;
    upperBound = -1;
    margin = 15;

    leftSlider = new Slider(dataManager.getYearsInOrder(), x, y, w, h, 0, Integer.valueOf(-5)); 
    rightSlider = new Slider(dataManager.getYearsInOrder(), x, y, w, h, dataManager.getYearsInOrder().size() - 1, Integer.valueOf(5));
    currentSlider = leftSlider;
    leftSlider.current = true;
    rightSlider.current = false;

    ribbonManager = new RibbonManager(dataManager, dataManager.getYearsInOrder(), x, y, w, h);
  }

  public void update() {
    leftSlider.update();
    rightSlider.update();
  }

  public Integer getLowerBoundYear() {
    return leftSlider.getYear();
  }

  public Integer getUpperBoundYear() {
    return rightSlider.getYear();
  }

  public void swapCurrentSlider() {
    if (rightSlider.current) {
      currentSlider = leftSlider;
    } else {
      currentSlider = rightSlider;
    }
    leftSlider.current = !leftSlider.current;
    rightSlider.current = !rightSlider.current;
  }

  public void render() {
    ribbonManager.render(leftSlider.getYear(), rightSlider.getYear());
    rightSlider.render();
    leftSlider.render();

    pushStyle();
    fill(0, 0, 255);
    List<Integer> yearsInOrder = dataManager.getYearsInOrder();
    Integer xOffset;
    
    if (yearsInOrder.size() == 1) {
      xOffset = w;
    } else {
      xOffset = (w) / (yearsInOrder.size() - 1);
    }

    Integer year;
    for (Integer i = 0; i < yearsInOrder.size (); i++) {
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

