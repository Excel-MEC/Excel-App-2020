

class DBEventsTable {

  // Table to store all events 
  // 1.Competitions
  // 2.Talks
  // 3.Workshops
  static String createEventTable(String tableName) {
    String table = "CREATE TABLE $tableName ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "icon TEXT,"
      "category TEXT,"
      "date_time TEXT"
      ")";
      return table;
  }

  // Table for storing event details
  static String createEventDetailsTable(String tableName) {
    String table = "CREATE TABLE $tableName ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "category TEXT,"
      "venue TEXT,"
      "prize_money TEXT,"
      "date_time TEXT,"
      "about TEXT,"
      "format TEXT,"
      "rules TEXT"
      ")";
      return table;
  }
  
}
