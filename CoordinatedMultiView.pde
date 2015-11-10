/*
 * Jake Mingolla
 * Dorian Pistilli
 *
 * Fall 2015
 */

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.Map.Entry;

String DISCIPLINE;
String DEPARTMENT;
String SPONSOR;
String YEAR;
String TOTAL;

Integer MARGIN;
Float MARGIN_RATIO = 0.05;

String path = "soe-funding2.csv";
List<Data> dataPoints;
DataManager dataManager;
PieChartManager pieChartManager;
TimelineManager timelineManager;
BarGraphManager barGraphManager;

Integer topX;
Integer topY;
Integer topW;
Integer topH;

Integer rightX;
Integer rightY;
Integer rightW;
Integer rightH;

Integer leftX;
Integer leftY;
Integer leftW;
Integer leftH;

String DISPLAYED_DEPARTMENT = "";

void setup() {
  size(displayWidth, (int)(displayHeight * 0.9));
  println(width + " " + height);
  dataPoints = new ArrayList<Data>();
  parse();

  Integer min = (int)min(width, height);
  MARGIN = (int)(min * MARGIN_RATIO);

  topX = MARGIN;
  topY = MARGIN;
  topW = (int)(width - (2 * MARGIN));
  topH = (int)(height/2 - 2*MARGIN);

  leftX = MARGIN;
  leftY = (int)(height/2 + MARGIN);
  leftW = (int)(width/2 - (2*MARGIN));
  leftH = (int)(height/2 - (2*MARGIN));

  rightX = (int)(width/2 + MARGIN);
  rightY = (int)(height/2 + MARGIN);
  rightW = (int)(width/2 - (2*MARGIN));
  rightH = (int)(height/2 - (2*MARGIN));

  //  for (Data d : dataPoints) {
  //    println(d.discipline + "," + d.department + "," +
  //      d.sponsor + "," + d.year + "," + d.funding);
  //  }
  //  println(dataPoints.size());
  dataManager = new DataManager(dataPoints);
  dataManager.getRibbonList();
  pieChartManager = new PieChartManager(dataManager, rightX, rightY, rightW, rightH);
  timelineManager = new TimelineManager(dataManager, topX, topY, topW, topH);
  barGraphManager = new BarGraphManager(dataManager, timelineManager.ribbonManager, leftX, leftY, leftW, leftH);

  //  Map<String, Float> pcd = dataManager.getPieChartData(2011, 2011);
  //  Float total = 0.0f;
  //  for (Entry<String, Float> entry : pcd.entrySet ()) {
  //    String sponsor = entry.getKey();
  //    Float percentage = entry.getValue();
  //    println("sponsor: " + sponsor + ", percentage: " + percentage);
  //    total += percentage;
  //  }
  //  println("total = " + total);
}



void draw() {
  timelineManager.update();
  background(200);
  fill(255);
  rect(topX, topY, topW, topH);
  rect(leftX, leftY, leftW, leftH);
  rect(rightX, rightY, rightW, rightH);
  timelineManager.render();
  Integer lowerBound = timelineManager.getLowerBoundYear();
  Integer upperBound = timelineManager.getUpperBoundYear();

  timelineManager.ribbonManager.updateFrameCounter();
  barGraphManager.update(lowerBound, upperBound, timelineManager.ribbonManager.getHighlightedDiscipline());
  barGraphManager.render();
  pieChartManager.update(lowerBound, upperBound);
  pieChartManager.render();
}

void parse() {
  String[] fileLines = loadStrings(path);
  String[] currLine = split(fileLines[0], ",");
  DISCIPLINE = currLine[0];
  DEPARTMENT = currLine[1];
  SPONSOR = currLine[2];
  YEAR = currLine[3];
  TOTAL = currLine[4];
  for (int i = 1; i < fileLines.length; i++) {
    currLine = split(fileLines[i], ",");
    Data data = new Data();
    data.discipline = currLine[0];
    data.department = currLine[1];
    data.sponsor = currLine[2];
    data.year = parseInt(currLine[3]);
    data.funding = parseInt(currLine[4]);
    dataPoints.add(data);
  }
}

void keyPressed() {
  if (key == CODED && keyCode == LEFT) {
    timelineManager.currentSlider.goLeft();
    if (timelineManager.leftSlider.currentIndex > timelineManager.currentSlider.currentIndex) {
      timelineManager.leftSlider.goLeft();
    }
  }
  if (key == CODED && keyCode == RIGHT) {
    timelineManager.currentSlider.goRight();
    if (timelineManager.rightSlider.currentIndex < timelineManager.currentSlider.currentIndex) {
      timelineManager.rightSlider.goRight();
    }
  }

  if (key == CODED && keyCode == DOWN) {
    if (timelineManager.ribbonManager.highlightedIndex < timelineManager.ribbonManager.disciplineList.size() - 1) {
      timelineManager.ribbonManager.highlightedIndex += 1;
    }
  }

  if (key == CODED && keyCode == UP) {
    if (timelineManager.ribbonManager.highlightedIndex > 0) {
      timelineManager.ribbonManager.highlightedIndex -= 1;
    }
  }
  if (key == ' ') {
    timelineManager.swapCurrentSlider();
  }
}

