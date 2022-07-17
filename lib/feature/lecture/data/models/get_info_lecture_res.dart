class GetInfoLectureResponse {
  bool? success;
  int? statusCode;
  GetInfoLectureData? data;

  GetInfoLectureResponse({this.success, this.statusCode, this.data});

  GetInfoLectureResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    data = json['data'] != null
        ? new GetInfoLectureData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class GetInfoLectureData {
  String? nameLecture;
  String? descriptionLecture;
  String? idCourse;
  List<FileUpload>? fileUpload;
  String? createDate;

  GetInfoLectureData(
      {this.nameLecture,
      this.descriptionLecture,
      this.idCourse,
      this.fileUpload,
      this.createDate});

  GetInfoLectureData.fromJson(Map<String, dynamic> json) {
    nameLecture = json['nameLecture'];
    descriptionLecture = json['descriptionLecture'];
    idCourse = json['idCourse'];
    if (json['fileUpload'] != null) {
      fileUpload = <FileUpload>[];
      json['fileUpload'].forEach((v) {
        fileUpload?.add(new FileUpload.fromJson(v));
      });
    }
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameLecture'] = this.nameLecture;
    data['descriptionLecture'] = this.descriptionLecture;
    data['idCourse'] = this.idCourse;
    if (this.fileUpload != null) {
      data['fileUpload'] = this.fileUpload?.map((v) => v.toJson()).toList();
    }
    data['createDate'] = this.createDate;
    return data;
  }
}

class FileUpload {
  String? fieldname;
  String? originalname;
  String? filename;
  String? pathname;
  String? mimetype;
  int? size;

  FileUpload(
      {this.fieldname,
      this.originalname,
      this.filename,
      this.pathname,
      this.mimetype,
      this.size});

  FileUpload.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    originalname = json['originalname'];
    filename = json['filename'];
    pathname = json['pathname'];
    mimetype = json['mimetype'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldname'] = this.fieldname;
    data['originalname'] = this.originalname;
    data['filename'] = this.filename;
    data['pathname'] = this.pathname;
    data['mimetype'] = this.mimetype;
    data['size'] = this.size;
    return data;
  }
}
