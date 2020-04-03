// Config file for tables

class DBConfig {
  // Competitions Table
  static final String competitions = "CREATE TABLE Competitions ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "icon TEXT,"
      "category TEXT,"
      "date_time TEXT"
      ")";

  // Events table
  static final String events = "CREATE TABLE Events ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "icon TEXT,"
      "category TEXT,"
      "date_time TEXT"
      ")";

  // Talks table
  static final String talks = "CREATE TABLE Talks ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "icon TEXT,"
      "category TEXT,"
      "date_time TEXT"
      ")";

  //Workshops table
  static final String workshops = "CREATE TABLE Workshops ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "icon TEXT,"
      "category TEXT,"
      "date_time TEXT"
      ")";
}
