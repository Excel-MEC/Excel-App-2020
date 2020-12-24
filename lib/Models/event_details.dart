class EventDetails {
  int id;
  String name;
  String icon;
  int categoryId;
  String category;
  int eventTypeId;
  String eventType;
  String about;
  String format;
  String rules;
  String venue;
  int day;
  String datetime;
  int entryFee;
  int prizeMoney;
  int eventHead1Id;
  String eventHead1;
  int eventHead2Id;
  String eventHead2;
  int isTeam;
  int teamSize;
  int eventStatusId;
  String eventStatus;
  int numberOfRounds;
  int currentRound;
  int needRegistration;
  int registrationOpen;
  String registrationEndDate;
  String button;
  String registrationLink;
  String rounds;
  String registration;

  EventDetails({
    this.id,
    this.name,
    this.icon,
    this.categoryId,
    this.category,
    this.eventTypeId,
    this.eventType,
    this.about,
    this.format,
    this.rules,
    this.venue,
    this.day,
    this.datetime,
    this.entryFee,
    this.prizeMoney,
    this.eventHead1Id,
    this.eventHead1,
    this.eventHead2Id,
    this.eventHead2,
    this.isTeam,
    this.teamSize,
    this.eventStatusId,
    this.eventStatus,
    this.numberOfRounds,
    this.currentRound,
    this.needRegistration,
    this.registrationOpen,
    this.registrationEndDate,
    this.button,
    this.registrationLink,
    this.rounds,
    this.registration,
  });

  EventDetails.fromJson(data) {
    id = data['id'];
    name = data['name'];
    icon = data['icon'];
    categoryId = data['categoryId'];
    category = data['category'];
    eventTypeId = data['eventTypeId'];
    eventType = data['eventType'];
    about = data['about'];
    format = data['format'];
    rules = data['rules'];
    venue = data['venue'];
    day = data['day'];
    datetime = data['datetime'];
    entryFee = data['entryFee'];
    prizeMoney = data['prizeMoney'];
    eventHead1Id = data['eventHead1Id'];
    eventHead1 = data['eventHead1'];
    eventHead2Id = data['eventHead2Id'];
    eventHead2 = data['eventHead2'];
    isTeam = (data['isTeam'] == true || data['isTeam'] == 1) ? 1 : 0;
    teamSize = data['teamSize'];
    eventStatusId = data['eventStatusId'];
    eventStatus = data['eventStatus'];
    numberOfRounds = data['numberOfRounds'];
    currentRound = data['currentRound'];
    needRegistration =
        (data['needRegistration'] == true || data['needRegistration'] == 1)
            ? 1
            : 0;
    needRegistration =
        (data['needRegistration'] == true || data['needRegistration'] == 1)
            ? 1
            : 0;
    registrationOpen =
        (data['registrationOpen'] == true || data['registrationOpen'] == 1)
            ? 1
            : 0;
    registrationEndDate = data['registrationEndDate'];
    button = data['button'];
    registrationLink = data['registrationLink'];
    rounds = data['rounds'];
    registration = data['registration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['categoryId'] = this.categoryId;
    data['category'] = this.category;
    data['eventTypeId'] = this.eventTypeId;
    data['eventType'] = this.eventType;
    data['about'] = this.about;
    data['format'] = this.format;
    data['rules'] = this.rules;
    data['venue'] = this.venue;
    data['day'] = this.day;
    data['datetime'] = this.datetime;
    // data['entryFee]'] = this.entryFee;
    data['prizeMoney'] = this.prizeMoney;
    data['eventHead1Id'] = this.eventHead1Id;
    data['eventHead1'] = this.eventHead1;
    data['eventHead2Id'] = this.eventHead2Id;
    data['eventHead2'] = this.eventHead2;
    data['isTeam'] = this.isTeam;
    data['teamSize'] = this.teamSize;
    data['eventStatusId'] = this.eventStatusId;
    data['eventStatus'] = this.eventStatus;
    data['numberOfRounds'] = this.numberOfRounds;
    data['currentRound'] = this.currentRound;
    data['needRegistration'] = this.needRegistration;
    data['registrationOpen'] = this.registrationOpen;
    data['registrationEndDate'] = this.registrationEndDate;
    data['button'] = this.button;
    data['registrationLink'] = this.registrationLink;
    data['rounds'] = this.rounds;
    return data;
  }
}
