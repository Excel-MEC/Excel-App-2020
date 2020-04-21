

class DBUserTable {
  // TODO: Store User Information
  String userTable() {
    String table = "CREATE TABLE User ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "email TEXT,"
      "picture TEXT,"
      "qrCodeUrl TEXT,"
      "institutionId TEXT,"
      "gender TEXT,"
      "gender TEXT,"
      "mobileNumber TEXT,"
      "category TEXT"
      ")";
      return table;
  }
} 