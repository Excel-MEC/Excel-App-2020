
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

  User(
      {this.id,
      this.name,
      this.email,
      this.picture,
      this.qrCodeUrl,
      this.institutionId,
      this.institutionName,
      this.gender,
      this.mobileNumber,
      this.category});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    picture = json['picture'];
    qrCodeUrl = json['qrCodeUrl'];
    institutionId = json['institutionId'];
    institutionName = json.containsKey('institutionName') ? json['institutionName'] : 'Not Registered'; 
    gender = json['gender'] != null ? json['gender'] : 'Not Registered';
    mobileNumber = json['mobileNumber'] != null ? json['mobileNumber'] : 'Not Registered';
    category = json['category'] != null ? json['category'] : 'Not Registered';
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
    data['category'] = this.category;
    return data;
  }
}


class Institution {
  int id;
  String name;

  Institution({this.id,this.name});

  Institution.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
  
}