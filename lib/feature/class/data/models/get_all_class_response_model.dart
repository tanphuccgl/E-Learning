class GetAllClassResponseModel {
  bool? success;
  int? statusCode;
  Meta? meta;
  List<GetAllClassData>? data;

  GetAllClassResponseModel(
      {this.success, this.statusCode, this.meta, this.data});

  GetAllClassResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <GetAllClassData>[];
      json['data'].forEach((v) {
        data!.add(new GetAllClassData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? total;
  int? pageSize;
  int? pageNumber;

  Meta({this.total, this.pageSize, this.pageNumber});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['page_size'];
    pageNumber = json['page_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page_size'] = this.pageSize;
    data['page_number'] = this.pageNumber;
    return data;
  }
}

class GetAllClassData {
  int? iId;
  String? nameClass;
  int? lv;
  bool? deleted;

  GetAllClassData({this.iId, this.nameClass, this.lv, this.deleted});

  GetAllClassData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    nameClass = json['nameClass'];
    lv = json['lv'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['nameClass'] = this.nameClass;
    data['lv'] = this.lv;
    data['deleted'] = this.deleted;
    return data;
  }
}
