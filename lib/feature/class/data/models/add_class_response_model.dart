class AddClassResponseModel {
  String? message;
  bool? success;
  int? status;

  AddClassResponseModel({this.message, this.success, this.status});

  AddClassResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}
