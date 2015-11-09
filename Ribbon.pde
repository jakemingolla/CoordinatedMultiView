public class Ribbon {
  public String department;
  public String discipline;
  public List<Integer> years;
  public List<Float> percentages;
  public Integer c;
  public Integer highc;

  Ribbon(String department, String discipline, 
  List<Integer> years, List<Float> percentages) {
    this.department = department;
    this.discipline = discipline;
    this.years = years;
    this.percentages = percentages;
    this.c = -1;
    this.highc = -1;
  }
}

