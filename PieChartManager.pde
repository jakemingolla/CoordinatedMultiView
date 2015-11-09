import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.Map.Entry;

public class PieChartManager {

  public PieChart pieChart;
  public DataManager dataManager;
  public Integer x, y, w, h;
  Integer currentLowerBound;
  Integer currentUpperBound;
  Map<String, Float> currentMap;
  List<String> currentNames;
  List<Float> currentPercentages;
  Integer margin;

  PieChartManager(DataManager dataManager, Integer x, Integer y, Integer w, Integer h) {
    this.dataManager = dataManager;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    currentLowerBound = -1;
    currentUpperBound = -1;
    currentMap = null;
    Integer min = min(w, h);
    margin = 15;
    this.pieChart = new PieChart(x + (w / 2), y + (h / 2), min - margin, min - margin);

  } 

  public void render(Integer lowerBound, Integer upperBound) {
    if (lowerBound != currentLowerBound || upperBound != currentUpperBound) {
      currentMap = dataManager.getPieChartData(lowerBound, upperBound);
      currentLowerBound = lowerBound;
      currentUpperBound = upperBound;
      currentNames = new ArrayList<String>();
      currentPercentages = new ArrayList<Float>();
      for (Entry<String, Float> entry : currentMap.entrySet ()) {
        currentNames.add(entry.getKey());
        currentPercentages.add(entry.getValue());
      }
    }

    if (currentLowerBound.equals(currentUpperBound)) {
      fill(0, 0, 255);
      text("Funding by Sponsor in " + currentLowerBound, x + margin, y + margin);
    } else {
      fill(0, 0, 255);
      text("Funding by Sponsor from " + currentLowerBound + " - " + currentUpperBound, x + margin, y + margin);
    }
    pieChart.render(currentNames, currentPercentages);
  }
}

