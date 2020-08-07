class DBUserTable {
  static String userTable() {
    String table = "CREATE TABLE User ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "email TEXT,"
        "picture TEXT,"
        "qrCodeUrl TEXT,"
        "institutionId INTEGER,"
        "institutionName TEXT,"
        "gender TEXT,"
        "mobileNumber TEXT,"
        "category TEXT"
        ")";
    return table;
  }
}
