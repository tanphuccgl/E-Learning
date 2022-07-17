class GetPointStudentResponse {
  bool? success;
  int? statusCode;
  List<GetPointStudentData>? data;

  GetPointStudentResponse({this.success, this.statusCode, this.data});

  GetPointStudentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <GetPointStudentData>[];
      json['data'].forEach((v) {
        data?.add(new GetPointStudentData.fromJson(v));
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

class GetPointStudentData {
  int? idAccount;
  String? idCourse;
  int? idExercise;
  String? titleExercise;
  int? idAnswer;
  var studyPoint;
  int? isTextPoint;

  GetPointStudentData(
      {this.idAccount,
      this.idCourse,
      this.idExercise,
      this.titleExercise,
      this.idAnswer,
      this.studyPoint,
      this.isTextPoint});

  GetPointStudentData.fromJson(Map<String, dynamic> json) {
    idAccount = json['idAccount'];
    idCourse = json['idCourse'];
    idExercise = json['idExercise'];
    titleExercise = json['titleExercise'];
    idAnswer = json['idAnswer'];
    studyPoint = json['studyPoint'];
    isTextPoint = json['isTextPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idAccount'] = this.idAccount;
    data['idCourse'] = this.idCourse;
    data['idExercise'] = this.idExercise;
    data['titleExercise'] = this.titleExercise;
    data['idAnswer'] = this.idAnswer;
    data['studyPoint'] = this.studyPoint;
    data['isTextPoint'] = this.isTextPoint;
    return data;
  }
}
