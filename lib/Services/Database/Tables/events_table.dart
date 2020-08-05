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
        "categoryId INTEGER,"
        "category TEXT,"
        "eventTypeId INTEGER,"
        "eventType TEXT,"
        "about TEXT,"
        "format TEXT,"
        "rules TEXT,"
        "venue TEXT,"
        "day INTEGER,"
        "datetime TEXT,"
        // "entryFee INTEGER,"
        "prizeMoney INTEGER,"
        "eventHead1Id INTEGER,"
        "eventHead1 BLOB,"
        "eventHead2Id INTEGER,"
        "eventHead2 BLOB,"
        "isTeam INTEGER,"
        "teamSize INTEGER,"
        "eventStatusId INTEGER,"
        "eventStatus TEXT,"
        "numberOfRounds INTEGER,"
        "currentRound INTEGER,"
        "needRegistration INTEGER,"
        "rounds TEXT"
        ")";
    return table;
  }
}
