class GetInfoExerciseResponse {
  bool? success;
  int? statusCode;
  GetInfoExerciseData? data;

  GetInfoExerciseResponse({this.success, this.statusCode, this.data});

  GetInfoExerciseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new GetInfoExerciseData.fromJson(json['data']) : null;
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

class GetInfoExerciseData {
  int? iId;
  int? idTeacher;
  String? idCourse;
  String? nameCourse;
  String? titleExercise;
  int? isTextPoint;
  List<FileUpload>? fileUpload;
  String? descriptionExercise;
  String? allowSubmission;
  String? submissionDeadline;
  String? createDate;
  String? updateDate;
  bool? deleted;

  GetInfoExerciseData(
      {this.iId,
        this.idTeacher,
        this.idCourse,
        this.nameCourse,
        this.titleExercise,
        this.isTextPoint,
        this.fileUpload,
        this.descriptionExercise,
        this.allowSubmission,
        this.submissionDeadline,
        this.createDate,
        this.updateDate,
        this.deleted});

  GetInfoExerciseData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    idTeacher = json['idTeacher'];
    idCourse = json['idCourse'];
    nameCourse = json['nameCourse'];
    titleExercise = json['titleExercise'];
    isTextPoint = json['isTextPoint'];
    if (json['fileUpload'] != null) {
      fileUpload = <FileUpload>[];
      json['fileUpload'].forEach((v) {
        fileUpload?.add(new FileUpload.fromJson(v));
      });
    }
    descriptionExercise = json['descriptionExercise'];
    allowSubmission = json['allowSubmission'];
    submissionDeadline = json['submissionDeadline'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['idTeacher'] = this.idTeacher;
    data['idCourse'] = this.idCourse;
    data['nameCourse'] = this.nameCourse;
    data['titleExercise'] = this.titleExercise;
    data['isTextPoint'] = this.isTextPoint;
    if (this.fileUpload != null) {
      data['fileUpload'] = this.fileUpload?.map((v) => v.toJson()).toList();
    }
    data['descriptionExercise'] = this.descriptionExercise;
    data['allowSubmission'] = this.allowSubmission;
    data['submissionDeadline'] = this.submissionDeadline;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['deleted'] = this.deleted;
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
