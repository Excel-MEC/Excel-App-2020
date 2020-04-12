// API config file

class APIConfig {
  static final String baseUrl = 'https://demo1680243.mockable.io';

  static String getEndpoint(String category) {
    // TODO: Replace MOCK API endpoints
    if (category == 'Competitions') return 'events';
    if (category == 'Events') return 'events';
    if (category == 'Talks') return 'events';
    if (category == 'Workshops') return 'events';
  }
}
