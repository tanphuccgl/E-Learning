class GetDashboardResponse {
  int? status;
  bool? success;
  String? message;
  GetDashboardData? data;

  GetDashboardResponse({this.status, this.success, this.message, this.data});

  GetDashboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new GetDashboardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class GetDashboardData {
  int? totalLecture;
  int? totalCourse;
  int? totalExercise;
  int? totalAnswer;
  int? totalStudent;
  int? totalTeacher;

  GetDashboardData(
      {this.totalLecture,
        this.totalCourse,
        this.totalExercise,
        this.totalAnswer,
        this.totalStudent,
        this.totalTeacher});

  GetDashboardData.fromJson(Map<String, dynamic> json) {
    totalLecture = json['totalLecture'];
    totalCourse = json['totalCourse'];
    totalExercise = json['totalExercise'];
    totalAnswer = json['totalAnswer'];
    totalStudent = json['totalStudent'];
    totalTeacher = json['totalTeacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalLecture'] = this.totalLecture;
    data['totalCourse'] = this.totalCourse;
    data['totalExercise'] = this.totalExercise;
    data['totalAnswer'] = this.totalAnswer;
    data['totalStudent'] = this.totalStudent;
    data['totalTeacher'] = this.totalTeacher;
    return data;
  }
}
