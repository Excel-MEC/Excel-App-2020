
class AccountConfig {

  //Auth0
  String baseUrl  = 'https://ajeshkumar.eu.auth0.com/';
  String clientId = 'Xcmx1whIj6t4qEUvzYkoXz1Icq3hHD3B'; 
  // TODO : Update rediret UI when app name changes
  String redirect = 'com.excelmec.app.excelapp://ajeshkumar.eu.auth0.com/android/com.excelmec.app.excelapp/callback';

  //Backend -- Accounts
  String url = 'http://34.71.37.228/api/';

  //header -- GET request
  Map<String,String> getHeader(String token) {
    return {
      "Content-Type"  : "application/json",
      "Accept"        : "application/json",
      "Authorization" : 'Bearer $token',
    };
  }
  
}

