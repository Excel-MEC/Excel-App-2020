 
 class DBFavouritesTable {
   
   static String favouritesTable() {
     String table = "CREATE TABLE Favourites ("
      "fav_id TEXT PRIMARY KEY,"
      "id INTEGER,"
      "name TEXT,"
      "icon TEXT,"
      "date_time TEXT,"
      "table_name TEXT"
      ")";
      return table;
   } 
   
 }