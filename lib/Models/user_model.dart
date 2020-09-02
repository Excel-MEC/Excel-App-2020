import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String role;
  String picture;
  String qrCodeUrl;
  int institutionId;
  String institutionName;
  String gender;
  String mobileNumber;
  int categoryId;
  String category;
  String ambassador;
  int referrerAmbassadorId;
  String referrer;
  bool isPaid;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.picture,
    this.qrCodeUrl,
    this.institutionId,
    this.institutionName,
    this.gender,
    this.mobileNumber,
    this.category,
    this.ambassador,
    this.referrerAmbassadorId,
    this.referrer,
    this.isPaid,
  });

  User.fromJson(json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    picture = json['picture'];
    qrCodeUrl = json['qrCodeUrl'];
    institutionId =
        json.containsKey('institutionId') ? json['institutionId'] : 0;
    institutionName =
        json.containsKey('institutionName') ? json['institutionName'] : null;
    gender = json['gender'];
    mobileNumber = json['mobileNumber'];
    categoryId = json['categoryId'];
    category = json['category'];
    ambassador = jsonEncode(json['ambassador']);
    referrerAmbassadorId = json['referrerAmbassadorId'];
    referrer = jsonEncode(json['referrer']);
    isPaid = (json['isPaid'] == true || json['isPaid'] == 1) ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['picture'] = this.picture;
    data['qrCodeUrl'] = this.qrCodeUrl;
    data['institutionId'] = this.institutionId;
    data['institutionName'] = this.institutionName;
    data['gender'] = this.gender;
    data['mobileNumber'] = this.mobileNumber;
    data['categoryId'] = this.categoryId;
    data['ambassador'] = jsonDecode(this.ambassador);
    data['referrerAmbassadorId'] = this.referrerAmbassadorId;
    data['referrer'] = jsonDecode(this.referrer);
    data['isPaid'] = this.isPaid;
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
