class GetMemberInCourseResponse {
  bool? success;
  int? statusCode;
  Meta? meta;
  List<GetMemberInCourseData>? data;

  GetMemberInCourseResponse(
      {this.success, this.statusCode, this.meta, this.data});

  GetMemberInCourseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <GetMemberInCourseData>[];
      json['data'].forEach((v) {
        data?.add(new GetMemberInCourseData.fromJson(v));
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

class GetMemberInCourseData {
  int? iId;
  int? idAccount;
  String? fullName;
  String? idCourse;
  String? nameCourse;
  String? role;
  String? createDate;
  bool? deleted;

  GetMemberInCourseData(
      {this.iId,
      this.idAccount,
      this.fullName,
      this.idCourse,
      this.nameCourse,
      this.role,
      this.createDate,
      this.deleted});

  GetMemberInCourseData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    idAccount = json['idAccount'];
    fullName = json['fullName'];
    idCourse = json['idCourse'];
    nameCourse = json['nameCourse'];
    role = json['role'];
    createDate = json['createDate'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['idAccount'] = this.idAccount;
    data['fullName'] = this.fullName;
    data['idCourse'] = this.idCourse;
    data['nameCourse'] = this.nameCourse;
    data['role'] = this.role;
    data['createDate'] = this.createDate;
    data['deleted'] = this.deleted;
    return data;
  }
}
