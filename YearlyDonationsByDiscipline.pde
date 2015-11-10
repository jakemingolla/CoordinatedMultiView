import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Map.Entry;

public class YearlyDonationsByDiscipline {
  Integer year;
  String discipline;
  Integer disciplineTotal;
  Integer grandTotal;
  List<String> departments;
  List<Integer> values;

  YearlyDonationsByDiscipline(Integer year, String discipline, List<String> departments) {

    this.year = year;
    this.discipline = discipline;
    this.disciplineTotal = 0;
    this.grandTotal = 0;
    this.departments = departments;
    this.values = new ArrayList<Integer>();
  }


  public void addValue(String deptName, Integer value) {
    int i;
    for (i = 0; i < departments.size (); i++) {
      if (departments.get(i).equals(deptName)) {
        break;
      }
    }

    if (i < values.size()) {
      values.set(i, values.get(i) + value);
    } else {
      values.add(value);
    }
    disciplineTotal += value;
  }

  public void setGrandTotal(Integer total) {
    grandTotal = total;
  }
}

