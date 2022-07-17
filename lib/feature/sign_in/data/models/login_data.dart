class LoginData {
  int? iId;
  String? fullName;
  int? idClass;
  String? nameClass;
  String? address;
  String? role;
  String? username;
  int? gender;
  String? token;

  LoginData(
      {this.iId,
      this.fullName,
      this.idClass,
      this.nameClass,
      this.address,
      this.role,
      this.username,
      this.gender,
      this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    fullName = json['fullName'];
    idClass = json['idClass'];
    nameClass = json['nameClass'];
    address = json['address'];
    role = json['role'];
    username = json['username'];
    gender = json['gender'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['fullName'] = this.fullName;
    data['idClass'] = this.idClass;
    data['nameClass'] = this.nameClass;
    data['address'] = this.address;
    data['role'] = this.role;
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['token'] = this.token;
    return data;
  }
}
