// API config file

class APIConfig {
  static final String baseUrl = 'https://staging.events.excelmec.org/api';

  static String getEndpoint(String category) {
    // TODO: Replace MOCK API endpoints
    if (category == 'Competitions') return 'events';
    if (category == 'Events') return 'events';
    if (category == 'Talks') return 'events';
    if (category == 'Workshops') return 'events';
  }
}
