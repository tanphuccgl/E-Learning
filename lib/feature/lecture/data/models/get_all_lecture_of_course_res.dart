class GetAllLectureResponse {
  bool? success;
  int? statusCode;
  List<GetAllLectureData>? data;

  GetAllLectureResponse({this.success, this.statusCode, this.data});

  GetAllLectureResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <GetAllLectureData>[];
      json['data'].forEach((v) {
        data?.add(new GetAllLectureData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllLectureData {
  int? iId;
  String? nameLecture;
  String? descriptionLecture;
  String? idCourse;
  List<FileUpload>? fileUpload;
  String? createDate;
  bool? deleted;
  int? iV;

  GetAllLectureData(
      {this.iId,
      this.nameLecture,
      this.descriptionLecture,
      this.idCourse,
      this.fileUpload,
      this.createDate,
      this.deleted,
      this.iV});

  GetAllLectureData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
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
    deleted = json['deleted'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['nameLecture'] = this.nameLecture;
    data['descriptionLecture'] = this.descriptionLecture;
    data['idCourse'] = this.idCourse;
    if (this.fileUpload != null) {
      data['fileUpload'] = this.fileUpload?.map((v) => v.toJson()).toList();
    }
    data['createDate'] = this.createDate;
    data['deleted'] = this.deleted;
    data['__v'] = this.iV;
    return data;
  }
}

class FileUpload {
  String? fieldname;
  String? originalname;
  String? encoding;
  String? mimetype;
  String? destination;
  String? filename;
  String? path;
  int? size;

  FileUpload(
      {this.fieldname,
      this.originalname,
      this.encoding,
      this.mimetype,
      this.destination,
      this.filename,
      this.path,
      this.size});

  FileUpload.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    originalname = json['originalname'];
    encoding = json['encoding'];
    mimetype = json['mimetype'];
    destination = json['destination'];
    filename = json['filename'];
    path = json['path'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldname'] = this.fieldname;
    data['originalname'] = this.originalname;
    data['encoding'] = this.encoding;
    data['mimetype'] = this.mimetype;
    data['destination'] = this.destination;
    data['filename'] = this.filename;
    data['path'] = this.path;
    data['size'] = this.size;
    return data;
  }
}
