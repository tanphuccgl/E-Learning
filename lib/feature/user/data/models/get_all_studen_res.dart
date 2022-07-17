class GetAllStudentResponse {
  bool? success;
  int? statusCode;
  Meta? meta;
  List<GetAllStudentData>? data;

  GetAllStudentResponse({this.success, this.statusCode, this.meta, this.data});

  GetAllStudentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <GetAllStudentData>[];
      json['data'].forEach((v) {
        data?.add(new GetAllStudentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.meta != null) {
      data['meta'] = this.meta?.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? total;
  int? pageSize;
  int? pageNumber;

  Meta({this.total, this.pageSize, this.pageNumber});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['page_size'];
    pageNumber = json['page_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page_size'] = this.pageSize;
    data['page_number'] = this.pageNumber;
    return data;
  }
}

class GetAllStudentData {
  int? iId;
  String? fullName;
  int? idClass;
  String? nameClass;
  String? address;
  Null? dateBirth;
  Null? phoneNumber;
  Null? parentName;
  Null? phoneNumberParent;
  String? role;
  String? username;
  String? email;
  String? password;
  Null? tokenResetPassword;
  int? gender;
  String? avatar;
  String? createDate;
  bool? deleted;
  int? iV;

  GetAllStudentData(
      {this.iId,
      this.fullName,
      this.idClass,
      this.nameClass,
      this.address,
      this.dateBirth,
      this.phoneNumber,
      this.parentName,
      this.phoneNumberParent,
      this.role,
      this.username,
      this.email,
      this.password,
      this.tokenResetPassword,
      this.gender,
      this.avatar,
      this.createDate,
      this.deleted,
      this.iV});

  GetAllStudentData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    fullName = json['fullName'];
    idClass = json['idClass'];
    nameClass = json['nameClass'];
    address = json['address'];
    dateBirth = json['dateBirth'];
    phoneNumber = json['phoneNumber'];
    parentName = json['parentName'];
    phoneNumberParent = json['phoneNumberParent'];
    role = json['role'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    tokenResetPassword = json['tokenResetPassword'];
    gender = json['gender'];
    avatar = json['avatar'];
    createDate = json['createDate'];
    deleted = json['deleted'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['fullName'] = this.fullName;
    data['idClass'] = this.idClass;
    data['nameClass'] = this.nameClass;
    data['address'] = this.address;
    data['dateBirth'] = this.dateBirth;
    data['phoneNumber'] = this.phoneNumber;
    data['parentName'] = this.parentName;
    data['phoneNumberParent'] = this.phoneNumberParent;
    data['role'] = this.role;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['tokenResetPassword'] = this.tokenResetPassword;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['createDate'] = this.createDate;
    data['deleted'] = this.deleted;
    data['__v'] = this.iV;
    return data;
  }
}
