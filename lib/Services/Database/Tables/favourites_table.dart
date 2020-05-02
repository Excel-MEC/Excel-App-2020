 
 class DBFavouritesTable {
   
   static String favouritesTable(String tableName) {
     String table = "CREATE TABLE $tableName ("
      "fav_id TEXT PRIMARY KEY,"
      "id INTEGER,"
      "name TEXT,"
      "icon TEXT,"
      "date_time TEXT,"
      "endpoint TEXT"
      ")";
      return table;
   } 
   
 }