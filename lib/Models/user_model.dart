// Replace this file with API data

var userMap = {
  "name": "Tom Holland",
  "email": "tomholland@gmail.com",
  "phone": "9876543210",
  "qrUrl":
      "https://i1.wp.com/digiday.com/wp-content/uploads/2012/07/QR_Code.png?fit=654%2C653&ssl=1",
  "imgUrl":
      "https://i.insider.com/5d152f42e06ee11bb36a1af7?width=1100&format=jpeg&auto=webp",
  "institutionId" : 123456789,
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
