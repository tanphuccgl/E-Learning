class GetGradeExerciseResponse {
  String? message;
  bool? success;
  int? status;
  List<GetGradeExerciseData>? data;

  GetGradeExerciseResponse(
      {this.message, this.success, this.status, this.data});

  GetGradeExerciseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    status = json['status'];
    if (json['data'] != null) {
      data = <GetGradeExerciseData>[];
      json['data'].forEach((v) {
        data?.add(new GetGradeExerciseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetGradeExerciseData {
  int? idAccount;
  String? fullName;
  String? idCourse;
  String? nameCourse;
  int? idExercise;
  var studyPoint;
  int? isTextPoint;
  String? createDate;
  String? updateDate;
  int? idAnswer;

  GetGradeExerciseData(
      {this.idAccount,
      this.fullName,
      this.idCourse,
      this.nameCourse,
      this.isTextPoint,
      this.idExercise,
      this.studyPoint,
      this.createDate,
      this.updateDate,
      this.idAnswer});

  GetGradeExerciseData.fromJson(Map<String, dynamic> json) {
    idAccount = json['idAccount'];
    fullName = json['fullName'];
    idCourse = json['idCourse'];
    nameCourse = json['nameCourse'];
    idExercise = json['idExercise'];
    studyPoint = json['studyPoint'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    idAnswer = json['idAnswer'];
    isTextPoint = json['isTextPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idAccount'] = this.idAccount;
    data['fullName'] = this.fullName;
    data['idCourse'] = this.idCourse;
    data['nameCourse'] = this.nameCourse;
    data['idExercise'] = this.idExercise;
    data['studyPoint'] = this.studyPoint;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['idAnswer'] = this.idAnswer;
    data['isTextPoint'] = this.isTextPoint;

    return data;
  }
}
