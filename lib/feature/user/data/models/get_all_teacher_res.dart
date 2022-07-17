class GetAllTeacherResponse {
  bool? success;
  int? statusCode;
  Meta? meta;
  List<GetAllTeacherData>? data;

  GetAllTeacherResponse({this.success, this.statusCode, this.meta, this.data});

  GetAllTeacherResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <GetAllTeacherData>[];
      json['data'].forEach((v) {
        data?.add(new GetAllTeacherData.fromJson(v));
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

class GetAllTeacherData {
  String? address;
  String? dateBirth;
  String? phoneNumber;
  String? parentName;
  String? phoneNumberParent;
  String? email;
  String? tokenResetPassword;
  int? iId;
  String? fullName;
  int? idClass;
  String? nameClass;
  String? role;
  String? username;
  String? password;
  int? gender;
  String? avatar;
  String? createDate;
  bool? deleted;
  int? iV;

  GetAllTeacherData(
      {this.address,
      this.dateBirth,
      this.phoneNumber,
      this.parentName,
      this.phoneNumberParent,
      this.email,
      this.tokenResetPassword,
      this.iId,
      this.fullName,
      this.idClass,
      this.nameClass,
      this.role,
      this.username,
      this.password,
      this.gender,
      this.avatar,
      this.createDate,
      this.deleted,
      this.iV});

  GetAllTeacherData.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    dateBirth = json['dateBirth'];
    phoneNumber = json['phoneNumber'];
    parentName = json['parentName'];
    phoneNumberParent = json['phoneNumberParent'];
    email = json['email'];
    tokenResetPassword = json['tokenResetPassword'];
    iId = json['_id'];
    fullName = json['fullName'];
    idClass = json['idClass'];
    nameClass = json['nameClass'];
    role = json['role'];
    username = json['username'];
    password = json['password'];
    gender = json['gender'];
    avatar = json['avatar'];
    createDate = json['createDate'];
    deleted = json['deleted'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['dateBirth'] = this.dateBirth;
    data['phoneNumber'] = this.phoneNumber;
    data['parentName'] = this.parentName;
    data['phoneNumberParent'] = this.phoneNumberParent;
    data['email'] = this.email;
    data['tokenResetPassword'] = this.tokenResetPassword;
    data['_id'] = this.iId;
    data['fullName'] = this.fullName;
    data['idClass'] = this.idClass;
    data['nameClass'] = this.nameClass;
    data['role'] = this.role;
    data['username'] = this.username;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['createDate'] = this.createDate;
    data['deleted'] = this.deleted;
    data['__v'] = this.iV;
    return data;
  }
}
