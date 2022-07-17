class GetPointTeacherResponse {
  bool? success;
  int? statusCode;
  List<Data>? data;

  GetPointTeacherResponse({this.success, this.statusCode, this.data});

  GetPointTeacherResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
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

class Data {
  int? idAccount;
  String? fullName;
  String? idCourse;
  String? nameCourse;
  List<GetPointTeacherData>? data;

  Data(
      {this.idAccount,
      this.fullName,
      this.idCourse,
      this.nameCourse,
      this.data});

  Data.fromJson(Map<String, dynamic> json) {
    idAccount = json['idAccount'];
    fullName = json['fullName'];
    idCourse = json['idCourse'];
    nameCourse = json['nameCourse'];
    if (json['data'] != null) {
      data = <GetPointTeacherData>[];
      json['data'].forEach((v) {
        data?.add(new GetPointTeacherData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idAccount'] = this.idAccount;
    data['fullName'] = this.fullName;
    data['idCourse'] = this.idCourse;
    data['nameCourse'] = this.nameCourse;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetPointTeacherData {
  int? iId;
  int? idAccount;
  String? idCourse;
  int? idExercise;
  List<FileUpload>? fileUpload;
  String? descriptionAnswer;
  double? studyPoint;
  String? feedbackFromTeacher;
  List<FileUpload>? feedbackFromTeacherByImage;
  String? createDate;
  String? updateDate;
  bool? deleted;
  int? iV;
  int? isTextPoint;

  GetPointTeacherData(
      {this.iId,
      this.idAccount,
      this.idCourse,
      this.idExercise,
      this.fileUpload,
      this.descriptionAnswer,
      this.studyPoint,
      this.feedbackFromTeacher,
      this.feedbackFromTeacherByImage,
      this.createDate,
      this.updateDate,
      this.deleted,
      this.iV,
      this.isTextPoint});

  GetPointTeacherData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    idAccount = json['idAccount'];
    idCourse = json['idCourse'];
    idExercise = json['idExercise'];
    if (json['fileUpload'] != null) {
      fileUpload = <FileUpload>[];
      json['fileUpload'].forEach((v) {
        fileUpload?.add(new FileUpload.fromJson(v));
      });
    }
    descriptionAnswer = json['descriptionAnswer'];
    studyPoint = json['studyPoint'];
    feedbackFromTeacher = json['feedbackFromTeacher'];
    if (json['feedbackFromTeacherByImage'] != null) {
      feedbackFromTeacherByImage = <FileUpload>[];
      json['feedbackFromTeacherByImage'].forEach((v) {
        feedbackFromTeacherByImage?.add(new FileUpload.fromJson(v));
      });
    }
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    deleted = json['deleted'];
    iV = json['__v'];
    isTextPoint = json['isTextPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['idAccount'] = this.idAccount;
    data['idCourse'] = this.idCourse;
    data['idExercise'] = this.idExercise;
    if (this.fileUpload != null) {
      data['fileUpload'] = this.fileUpload?.map((v) => v.toJson()).toList();
    }
    data['descriptionAnswer'] = this.descriptionAnswer;
    data['studyPoint'] = this.studyPoint;
    data['feedbackFromTeacher'] = this.feedbackFromTeacher;
    if (this.feedbackFromTeacherByImage != null) {
      data['feedbackFromTeacherByImage'] =
          this.feedbackFromTeacherByImage?.map((v) => v.toJson()).toList();
    }
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['deleted'] = this.deleted;
    data['__v'] = this.iV;
    data['isTextPoint'] = this.isTextPoint;
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
