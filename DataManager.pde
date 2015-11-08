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
  
  // Slider data
  List<Integer> yearsInOrder;

  DataManager(List<Data> rawData) {
    this.rawData = rawData;
    donationsByYear = new HashMap<Integer, Map<String, Integer>>();
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

    //    for (Entry<Integer, Map<String, Integer>> entry : donationsByYear.entrySet ()) {
    //      Integer year = entry.getKey();
    //      Map<String, Integer> map = entry.getValue();
    //      println("Year: " + year);
    //
    //      for (Entry<String, Integer> secondEntry : map.entrySet ()) {
    //        String sponsor = secondEntry.getKey();
    //        Integer funding = secondEntry.getValue();
    //        println("    sponsor: " + sponsor + ", funding: " + funding);
    //      }
    //    }
  }

  public Map<String, Float> getPieChartData(Integer lowerBound, Integer upperBound) {
    Map<String, Integer> pieInitialChartData = new HashMap<String, Integer>();
    Integer sum = 0;

    for (Integer i = lowerBound; i <= upperBound; i++) {
      Map<String, Integer> map = donationsByYear.get(i);
      for (Entry<String, Integer> entry : map.entrySet()) {
        String sponsor = entry.getKey();
        Integer funding = entry.getValue();
        pieInitialChartData.put(sponsor, funding);
        sum += funding;
      }
    }

    Map<String, Float> percentages = new HashMap<String, Float>();

    for (Entry<String, Integer> entry : pieInitialChartData.entrySet()) {
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

