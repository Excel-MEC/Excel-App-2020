

class DBEventsTable {  

  // Events Table
  static String eventTable(String tableName) {
    String table = "CREATE TABLE $tableName ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "icon TEXT,"
      "eventType TEXT,"
      "category TEXT,"
      "datetime TEXT"
      ")";
      return table;
  } 

  // Event Details Table
  static String eventDetailsTable(String tableName) {
    String table = "CREATE TABLE $tableName ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "icon TEXT,"
      "datetime TEXT,"
      "prizeMoney INTEGER,"
      "venue TEXT,"
      "about TEXT,"
      "format TEXT,"
      "rules TEXT"
      ")";
      return table;
  }
  
}
