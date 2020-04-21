
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
    institutionName = json['institutionName'] != null ? json['institutionName'] : 'Not Registered'; 
    gender = json['gender'];
    mobileNumber = json['mobileNumber'];
    category = json['category'];
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

var userMap = {
  "name": "Tom Holland",
  "email": "tomholland@gmail.com",
  "phone": "9876543210",
  "qrUrl":
      "https://i1.wp.com/digiday.com/wp-content/uploads/2012/07/QR_Code.png?fit=654%2C653&ssl=1",
  "imgUrl":
      "https://i.insider.com/5d152f42e06ee11bb36a1af7?width=1100&format=jpeg&auto=webp",
  "institutionId": 123456789,
  "institutionName": "Model Eng College",
  "isCollege": true,
};

class Person {
  String name;
  String imageUrl;
  String qrUrl;
  String email;
  String phone;
  String gender;
  int institutionId;
  String institutionName;
  bool isCollege;

  Person(
      {this.name,
      this.imageUrl,
      this.qrUrl,
      this.email,
      this.phone,
      this.institutionId,
      this.institutionName,
      this.isCollege});

  Person.fromMapObject(Map<String, dynamic> map) {
    this.name = map['name'];
    this.imageUrl = map['imgUrl'];
    this.qrUrl = map['qrUrl'];
    this.phone = map['phone'];
    this.email = map['email'];
    this.institutionId = map['institutionId'];
    this.institutionName = map['institutionName'];
    this.isCollege = map['isCollege'];
  }
}
