public class Data {

  public String discipline;
  public String department;
  public String sponsor;
  public Integer year;
  public Integer funding;

  Data() {
  }

  void printSelf() {
    println(discipline + "," + department + "," +
      sponsor + "," + year + "," + funding);
  }

  Data(String discipline, String department, String sponsor, 
  Integer year, Integer funding) {
    this.discipline = discipline;
    this.department = department;
    this.sponsor = sponsor;
    this.year = year;
    this.funding = funding;
  }
}

