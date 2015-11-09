import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.Map.Entry;
import java.util.HashMap;
import java.util.Collections;

public class DataManager {
  List<Data> rawData;

  // Sponsor data
  Map<Integer, Map<String, Integer>> donationsByYear;

  // Timeline
  List<List<YearlyDonationsByDiscipline>> donationsByYearByDiscipline;

  // Slider data
  List<Integer> yearsInOrder;

  // years -> total
  Map<Integer, Integer> subTotalByYear;

  Integer grandTotal;

  DataManager(List<Data> rawData) {
    this.rawData = rawData;
    donationsByYear = new HashMap<Integer, Map<String, Integer>>();
    subTotalByYear = new HashMap<Integer, Integer>();
    yearsInOrder = new ArrayList<Integer>();

    for (Data d : rawData) {
      Map<String, Integer> map = donationsByYear.get(d.year);

      if (map != null) {
        Integer currentFunding = map.get(d.sponsor);
        if (currentFunding == null) { 
          currentFunding = 0;
        }
        map.put(d.sponsor, currentFunding + d.funding);
      } else {
        map = new HashMap<String, Integer>();
        map.put(d.sponsor, d.funding);
      }
      donationsByYear.put(d.year, map);

      if (!yearExists(d.year)) {
        yearsInOrder.add(d.year);
      }
    }

    Collections.sort(yearsInOrder);

    Map<String, List<String>> departmentsByDiscipline = new HashMap<String, List<String>>();
    for (Data d : rawData) {

      List<String> l = departmentsByDiscipline.get(d.discipline);

      if (l == null) {
        l = new ArrayList<String>();
        l.add(d.department);
      } else {
        Boolean found = false;
        for (String dept : l) {
          if (dept.equals(d.department)) {
            found = true;
            break;
          }
        }
        if (!found) {
          l.add(d.department);
        }
      }

      departmentsByDiscipline.put(d.discipline, l);
    }

    Integer lowerBound = yearsInOrder.get(0);
    Integer upperBound = yearsInOrder.get(yearsInOrder.size() - 1);

    donationsByYearByDiscipline = new ArrayList<List<YearlyDonationsByDiscipline>>();
    grandTotal = 0;
    Integer subTotal;
    for (Integer year = lowerBound; year <= upperBound; year++) {
      subTotal = 0;
      List<YearlyDonationsByDiscipline> l = new ArrayList<YearlyDonationsByDiscipline>();
      for (Entry<String, List<String>> entry : departmentsByDiscipline.entrySet ()) {
        String discipline = entry.getKey();
        List<String> departments = entry.getValue();
        YearlyDonationsByDiscipline ydbd = new YearlyDonationsByDiscipline(year, discipline, departments);
        for (String department : departments) {
          Integer val = findValue(year, discipline, department);
          ydbd.addValue(department, val);
          grandTotal += val;
          subTotal += val;
        }
        l.add(ydbd);
      }
      donationsByYearByDiscipline.add(l);
      subTotalByYear.put(year, subTotal);
    }
    /*
    for (List<YearlyDonationsByDiscipline> l : donationsByYearByDiscipline) {
     for (YearlyDonationsByDiscipline ydbd : l) {
     println("year = " + ydbd.year + ", " + 
     "discipline = " + ydbd.discipline + ", " +
     "departments = {");
     int i;
     int len = ydbd.departments.size();
     for (i = 0; i < len; i++) {
     println("     deptartment = " + ydbd.departments.get(i) + " , value = " + ydbd.values.get(i));
     }
     println("}");
     }
     }
     */
  }

  public List<Ribbon> getTimelineData() {
    List<Ribbon> ribbonList = new ArrayList<Ribbon>();
    for (List<YearlyDonationsByDiscipline> l : donationsByYearByDiscipline) {
      for (YearlyDonationsByDiscipline ydbd : l) {
        int i;
        int len = ydbd.departments.size();
        for  (i = 0; i < len; i++) {
          String department = ydbd.departments.get(i);
          Integer value = ydbd.values.get(i);
          Integer subTotal = subTotalByYear.get(ydbd.year);
          Boolean found = false;
          for (Ribbon ribbon : ribbonList) {
            if (ribbon.department.equals(department)) {
              found = true;
              ribbon.years.add(ydbd.year);
              ribbon.percentages.add((float)((float)ydbd.values.get(i) / (float)subTotal));
            }
          }
          if (!found) {
            List<Integer> years = new ArrayList<Integer>();
            years.add(ydbd.year);
            List<Float> percentages = new ArrayList<Float>();
            percentages.add((float)((float)ydbd.values.get(i) / (float)subTotal));
            Ribbon ribbon = new Ribbon(department, ydbd.discipline, years, percentages);
            ribbonList.add(ribbon);
          }
        }
      }
    }

    for (Ribbon ribbon : ribbonList) {
      println("discipline = " + ribbon.discipline + ", department = " + ribbon.department + " {");
      int i;
      int len = ribbon.years.size();
      for (i = 0; i < len; i++) {
        Integer year = ribbon.years.get(i);
        Float percentage = ribbon.percentages.get(i);
        println("      year = " + year + ", percentage = " + percentage * 100);
      }
      println("}");
    }
    return ribbonList;
  }

  public Integer getGrandTotal() {
    return grandTotal;
  }

  public Integer findValue(Integer year, String discipline, String department) {
    Integer sum = 0; 
    for (Data d : rawData) {
      if (d.department.equals(department) && d.discipline.equals(discipline) && d.year.equals(year)) {
        sum += d.funding;
      }
    }
    return sum;
  }

  public Map<String, Float> getPieChartData(Integer lowerBound, Integer upperBound) {
    Map<String, Integer> pieInitialChartData = new HashMap<String, Integer>(); 
    Integer sum = 0; 

    for (Integer i = lowerBound; i <= upperBound; i++) {
      Map<String, Integer> map = donationsByYear.get(i); 
      for (Entry<String, Integer> entry : map.entrySet ()) {
        String sponsor = entry.getKey(); 
        Integer funding = entry.getValue(); 
        pieInitialChartData.put(sponsor, funding); 
        sum += funding;
      }
    }

    Map<String, Float> percentages = new HashMap<String, Float>(); 

    for (Entry<String, Integer> entry : pieInitialChartData.entrySet ()) {
      String sponsor = entry.getKey(); 
      Integer funding = entry.getValue(); 
      percentages.put(sponsor, ((float)funding / (float)sum));
    }

    return percentages;
  }

  public List<Integer> getYearsInOrder() {
    return yearsInOrder;
  }

  public Boolean yearExists(Integer query) {
    for (Integer year : yearsInOrder) {
      if (year.equals(query)) {
        return true;
      }
    }
    return false;
  }
}

