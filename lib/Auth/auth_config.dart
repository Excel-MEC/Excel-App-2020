
class AuthConfig {

  //Auth0
  String baseUrl  = 'https://ajeshkumar.eu.auth0.com/';
  String clientId = 'Xcmx1whIj6t4qEUvzYkoXz1Icq3hHD3B'; 
  String redirect = 'com.example.auth0://dev-0r1qzlil.auth0.com/android/com.example.auth0/callback';

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

