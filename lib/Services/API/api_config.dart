// API config file

class APIConfig {
  // static final String baseUrl = 'https://staging.events.excelmec.org/api/';
  static final String baseUrl = 'https://events.excelmec.org/';

  static String getEndpoint(String category) {
    if (category == 'Competitions') return 'competition';
    if (category == 'General') return 'general';
    if (category == 'Talks') return 'talk';
    if (category == 'Workshops') return 'workshop';
    if (category == 'Conferences') return 'conference';
    return category;
  }
}
