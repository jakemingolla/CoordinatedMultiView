public class BarGraphManager {
  public Integer x, y, w, h;
  public Integer currentLowerBound, currentUpperBound;
  public String currentDiscipline;
  BarGraph barGraph;
  DataManager dataManager;

  BarGraphManager(DataManager dataManager, RibbonManager ribbonManager, Integer x, Integer y, Integer w, Integer h) {
    this.x = x;
    this.y =y;
    this.w = w;
    this.h = h;
    this.dataManager = dataManager;
    currentLowerBound = -1;
    currentUpperBound = -1;
    currentDiscipline = "";
    barGraph = new BarGraph(ribbonManager, x, y, w, h);
  }

  public void update(Integer lowerBound, Integer upperBound, String discipline) {
    if (!currentLowerBound.equals(lowerBound) || !currentUpperBound.equals(upperBound) || !currentDiscipline.equals(discipline) || keyPressed && key == 'c') {
      println("ITS DIFFERENT");  
      currentLowerBound = lowerBound;
      currentUpperBound = upperBound;
      currentDiscipline = discipline;

      barGraph.update(dataManager.getBarGraphData(currentLowerBound, currentUpperBound, currentDiscipline));
    }
  }

  public void render() {
    barGraph.render();
  }
}

