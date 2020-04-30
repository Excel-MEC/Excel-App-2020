

class DBEventsTable {

  // To obtain details table name for corresponding category
  static String tableName(String endpoint) {
    if(endpoint == "Competitions") return "Competitions";
    if(endpoint == "Events") return "Events";
    if(endpoint == "Workshops") return "Workshops";
  }
  

  // For table Creations
  static String eventTable(String tableName) {
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
  static String eventDetailsTable(String tableName) {
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
