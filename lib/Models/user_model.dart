class User {
  int id;
  String name;
  String email;
  String picture;
  String qrCodeUrl;
  int institutionId;
  String institutionName;
  String gender;
  String mobileNumber;
  String category;
  int referrerAmbassadorId;
  String referrer;
  bool isPaid;

  User({
    this.id,
    this.name,
    this.email,
    this.picture,
    this.qrCodeUrl,
    this.institutionId,
    this.institutionName,
    this.gender,
    this.mobileNumber,
    this.category,
    this.referrerAmbassadorId,
    this.referrer,
    this.isPaid,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    picture = json['picture'];
    qrCodeUrl = json['qrCodeUrl'];
    institutionId =
        json.containsKey('institutionId') ? json['institutionId'] : 0;
    institutionName = json.containsKey('institutionName')
        ? json['institutionName']
        : 'Not Registered';
    gender = json['gender'] != null ? json['gender'] : 'Not Registered';
    mobileNumber =
        json['mobileNumber'] != null ? json['mobileNumber'] : 'Not Registered';
    category = json['category'] != null ? json['category'] : 'Not Registered';
    referrerAmbassadorId = json['referrerAmbassadorId'];
    referrer = json['referrer'];
    isPaid = (json['isPaid'] == true || json['isPaid'] == 1);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['qrCodeUrl'] = this.qrCodeUrl;
    data['institutionId'] = this.institutionId;
    data['institutionName'] = this.institutionName;
    data['gender'] = this.gender;
    data['mobileNumber'] = this.mobileNumber;
    data['referrerAmbassadorId'] = this.referrerAmbassadorId;
    data['referrer'] = this.referrer;
    data['isPaid'] = this.isPaid ? 1 : 0;
    return data;
  }
}

class Institution {
  int id;
  String name;

  Institution({this.id, this.name});

  Institution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
