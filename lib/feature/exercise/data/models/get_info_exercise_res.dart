class GetInfoExerciseResponse {
  bool? success;
  int? statusCode;
  GetInfoExerciseData? data;

  GetInfoExerciseResponse({this.success, this.statusCode, this.data});

  GetInfoExerciseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    data = json['data'] != null
        ? new GetInfoExerciseData.fromJson(json['data'])
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

class GetInfoExerciseData {
  int? idAnswer;
  int? idExercise;
  int? idTeacher;
  String? idCourse;
  String? nameCourse;
  String? titleExercise;
  String? descriptionExercise;
  int? isTextPoint;
  String? allowSubmission;
  String? submissionDeadline;
  int? totalNumberOfSubmissions;
  int? totalNumberOfGradedSubmissions;
  int? totalStudentInCourse;
  List<Files>? files;
  String? createDate;
  String? updateDate;

  GetInfoExerciseData(
      {this.idAnswer,
      this.idExercise,
      this.idTeacher,
      this.idCourse,
      this.nameCourse,
      this.titleExercise,
      this.descriptionExercise,
      this.isTextPoint,
      this.allowSubmission,
      this.submissionDeadline,
      this.totalNumberOfSubmissions,
      this.totalNumberOfGradedSubmissions,
      this.totalStudentInCourse,
      this.files,
      this.createDate,
      this.updateDate});

  GetInfoExerciseData.fromJson(Map<String, dynamic> json) {
    idAnswer = json['idAnswer'];
    idExercise = json['idExercise'];
    idTeacher = json['idTeacher'];
    idCourse = json['idCourse'];
    nameCourse = json['nameCourse'];
    titleExercise = json['titleExercise'];
    descriptionExercise = json['descriptionExercise'];
    isTextPoint = json['isTextPoint'];
    allowSubmission = json['allowSubmission'];
    submissionDeadline = json['submissionDeadline'];
    totalNumberOfSubmissions = json['totalNumberOfSubmissions'];
    totalNumberOfGradedSubmissions = json['totalNumberOfGradedSubmissions'];
    totalStudentInCourse = json['totalStudentInCourse'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files?.add(new Files.fromJson(v));
      });
    }
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idAnswer'] = this.idAnswer;
    data['idExercise'] = this.idExercise;
    data['idTeacher'] = this.idTeacher;
    data['idCourse'] = this.idCourse;
    data['nameCourse'] = this.nameCourse;
    data['titleExercise'] = this.titleExercise;
    data['descriptionExercise'] = this.descriptionExercise;
    data['isTextPoint'] = this.isTextPoint;
    data['allowSubmission'] = this.allowSubmission;
    data['submissionDeadline'] = this.submissionDeadline;
    data['totalNumberOfSubmissions'] = this.totalNumberOfSubmissions;
    data['totalNumberOfGradedSubmissions'] =
        this.totalNumberOfGradedSubmissions;
    data['totalStudentInCourse'] = this.totalStudentInCourse;
    if (this.files != null) {
      data['files'] = this.files?.map((v) => v.toJson()).toList();
    }
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    return data;
  }
}

class Files {
  String? fieldname;
  String? originalname;
  String? filename;
  String? pathname;
  String? mimetype;
  int? size;

  Files(
      {this.fieldname,
      this.originalname,
      this.filename,
      this.pathname,
      this.mimetype,
      this.size});

  Files.fromJson(Map<String, dynamic> json) {
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
