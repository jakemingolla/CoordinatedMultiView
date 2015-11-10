public class RibbonManager {
  Integer x, y, w, h;
  DataManager dataManager;
  List<Ribbon> ribbonList;
  List<Integer> yearsInOrder;
  List<String> disciplineList;
  Map<String, List<String>> departmentsByDiscipline;
  List<Integer> disciplineColorList;
  List<String> orderedDisciplineList;
  Float xOffset;
  Integer frameCounter;
  boolean fcIncreasing;
  Integer highlightedIndex;
  RibbonManager(DataManager dataManager, List<Integer> yearsInOrder, Integer x, Integer y, Integer w, Integer h) {
    this.dataManager = dataManager;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    ribbonList = dataManager.getRibbonList();
    disciplineList = dataManager.getDisciplineList();
    orderedDisciplineList = createOrderedDisciplineList();
    departmentsByDiscipline = dataManager.getDepartmentsByDiscipline();
    this.yearsInOrder = yearsInOrder;

    setColors();
    frameCounter = 0;
    fcIncreasing = true;
    highlightedIndex = 0;

    if (yearsInOrder.size() <= 1) {
      xOffset = (float)w;
    } else {
      xOffset = (float)((w + yearsInOrder.size()) / (yearsInOrder.size() - 1)); // offset for floating point difference
    }
  }

  public String getHighlightedDiscipline() {
    return orderedDisciplineList.get(highlightedIndex);
  }

  float tintFactor = 0.5f;

  public void setHighC(Ribbon r) {
    int red, green, blue;
    red = (int)red(r.c);
    red = floor(red + (255-red)*tintFactor);

    green = (int)green(r.c);
    green = floor(green + (255-green)*tintFactor);

    blue = (int)blue(r.c);
    blue = floor(blue + (255-blue)*tintFactor);

    r.highc = color(red, green, blue);
  }

  public void render(Integer lowerBound, Integer upperBound) {
    if (keyPressed && key == 'c') {
      setColors();
      for (Ribbon r : ribbonList) {
        r.c = getColorByDisciplineAndDepartment(r.discipline, r.department);
        setHighC(r);
      }
    }


    if (ribbonList != null) {
      int i;
      int len = yearsInOrder.size() - 1;

      Float x1, x2, x3, x4, y1, y2, y3, y4;

      if (len == 0) {
        len = 1;
      }

      for (i = 0; i < len; i++) {

        Float currentPercentage1 = 0.0f;
        Float currentPercentage2 = 0.0f;
        x1 = (float)x + xOffset * i;
        y1 = (float)y;
        x2 = (float)(x + xOffset * (i + 1));
        y2 = (float)y;
        int j;
        int ribbonLength = ribbonList.size();
        for (j = 0; j < ribbonLength; j++) {
          Ribbon r1 = ribbonList.get(j);

          x3 = x1;
          y3 = y1 + (h * r1.percentages.get(i));
          x4 = x2;
          if (len == 1) {
            y4 = y2 + (h * r1.percentages.get(i));
          } else {
            y4 = y2 + (h * r1.percentages.get(i + 1));
          }

          Integer year = yearsInOrder.get(i);
          if (r1.c.equals(-1)) {
            r1.c = getColorByDisciplineAndDepartment(r1.discipline, r1.department);
            setHighC(r1);
          }
          if (year >= lowerBound && year < upperBound) {
            if (r1.discipline.equals(orderedDisciplineList.get(highlightedIndex))) {
              fill(r1.highc, frameCounter % 255);
            } else {
              fill(r1.highc);
            }
          } else {
            fill(r1.c);
          }


          quad(x1, y1, x2, y2, x4, y4, x3, y3); // clockwise rotation
          currentPercentage1 += r1.percentages.get(i);
          if (len != 1) {
            currentPercentage2 += r1.percentages.get(i + 1);
          }
          //println("year = " + year + " percentage = " + currentPercentage1);
          x1 = x3;
          x2 = x4;
          y1 = y3;
          y2 = y4;
        }
      }
    }
  }

  public void setColors() {
    disciplineColorList = new ArrayList<Integer>();
    for (String disc : disciplineList) {
      disciplineColorList.add(color(random(255), random(255), random(255)));
    }
  }

  public color getColorByDisciplineAndDepartment(String discipline, String department) {

    List<String> departments = departmentsByDiscipline.get(discipline);
    Integer innerSize = departments.size();
    Integer innerIndex = 0;
    for (int i = 0; i < innerSize; i++) {
      if (departments.get(i).equals(department)) {
        innerIndex = i;
      }
    }
    Integer outerSize = disciplineList.size();
    Integer outerIndex = 0;
    for (int i = 0; i < outerSize; i++) {
      if (disciplineList.get(i).equals(discipline)) {
        outerIndex = i;
      }
    }
    Integer outerOffset = 255 / outerSize;
    Integer innerOffset = outerOffset / innerSize;
    color c = color(disciplineColorList.get(outerIndex), 255 - innerOffset * innerIndex);
    return c;
  }

  public String getDepartmentByColor(color c) {
    Float EPSILON = 2.0f;
    for (Ribbon r : ribbonList) {
      if (abs(c - r.c) < EPSILON || abs(c - r.highc) < EPSILON) {
        return r.department;
      }
    }
    return "NOT FOUND";
  }

  public void updateFrameCounter() {
    final Integer DELTA = 8;
    if (frameCounter >= 255 - DELTA) {
      fcIncreasing = false;
    } else if (frameCounter <= 0 + DELTA) {
      fcIncreasing = true;
    }
    if (fcIncreasing) {
      frameCounter += DELTA;
    } else {
      frameCounter -= DELTA;
    }
  }

  public List<String> createOrderedDisciplineList() {
    List<String> ordered = new ArrayList<String>();
    for (Ribbon ribbon : ribbonList) {
      boolean found = false;
      for (String discipline : ordered) {
        if (discipline.equals(ribbon.discipline)) {
          found = true;
        }
      }
      if (!found) {
        ordered.add(ribbon.discipline);
      }
    }
    return ordered;
  }
}

