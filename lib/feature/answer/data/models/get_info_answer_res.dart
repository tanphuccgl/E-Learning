class GetInformationAnswerResponse {
  bool? success;
  int? statusCode;
  GetInformationAnswerData? data;

  GetInformationAnswerResponse({this.success, this.statusCode, this.data});

  GetInformationAnswerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    data = json['data'] != null
        ? new GetInformationAnswerData.fromJson(json['data'])
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

class GetInformationAnswerData {
  int? iId;
  int? idAccount;
  int? idExercise;
  String? descriptionAnswer;
  List<FileUpload>? fileUpload;
  var studyPoint;
  int? isTextPoint;
  String? feedbackFromTeacher;
  List<FileUpload>? feedbackFromTeacherByImage;
  String? createDate;
  String? updateDate;

  GetInformationAnswerData(
      {this.iId,
      this.idAccount,
      this.idExercise,
      this.descriptionAnswer,
      this.fileUpload,
      this.studyPoint,
      this.isTextPoint,
      this.feedbackFromTeacher,
      this.feedbackFromTeacherByImage,
      this.createDate,
      this.updateDate});

  GetInformationAnswerData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    idAccount = json['idAccount'];
    idExercise = json['idExercise'];
    descriptionAnswer = json['descriptionAnswer'];
    if (json['fileUpload'] != null) {
      fileUpload = <FileUpload>[];
      json['fileUpload'].forEach((v) {
        fileUpload?.add(new FileUpload.fromJson(v));
      });
    }
    studyPoint = json['studyPoint'];
    isTextPoint = json['isTextPoint'];
    feedbackFromTeacher = json['feedbackFromTeacher'];

    if (json['feedbackFromTeacherByImage'] != null) {
      feedbackFromTeacherByImage = <FileUpload>[];
      json['feedbackFromTeacherByImage'].forEach((v) {
        feedbackFromTeacherByImage?.add(new FileUpload.fromJson(v));
      });
    }
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['idAccount'] = this.idAccount;
    data['idExercise'] = this.idExercise;
    data['descriptionAnswer'] = this.descriptionAnswer;
    if (this.fileUpload != null) {
      data['fileUpload'] = this.fileUpload?.map((v) => v.toJson()).toList();
    }
    data['studyPoint'] = this.studyPoint;
    data['isTextPoint'] = this.isTextPoint;
    if (this.feedbackFromTeacherByImage != null) {
      data['feedbackFromTeacherByImage'] =
          this.feedbackFromTeacherByImage?.map((v) => v.toJson()).toList();
    }
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
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
