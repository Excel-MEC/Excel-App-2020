// API config file

class APIConfig {
  static final String baseUrl = 'https://staging.apis.excelmec.org/events/api';

  static String getEndpoint(String category) {
    if (category == 'Competitions') return 'competition';
    if (category == 'General') return 'general';
    if (category == 'Talks') return 'talk';
    if (category == 'Workshops') return 'workshop';
    if (category == 'Conferences') return 'conference';
    return null;
  }
}
