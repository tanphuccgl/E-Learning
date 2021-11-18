import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/data/models/list_teacher_response_model.dart';

abstract class ListTeacherRemoteDataSource {
  Future<ListTeacherResponseModel> getListTeacher();
}

class ListTeacherRemoteDataSourceImpl implements ListTeacherRemoteDataSource {
  final http.Client? client;

  ListTeacherRemoteDataSourceImpl({@required this.client});

  @override
  Future<ListTeacherResponseModel> getListTeacher() {
    return _getListTeacher();
  }

  Future<ListTeacherResponseModel> _getListTeacher() async {
    final response = await client?.get(
      Uri.parse('http://149.28.129.166:3000/account/GetTeacherWithIdAndName'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    log("Get getListTeacher: " +
        "http://149.28.129.166:3000/account/GetTeacherWithIdAndName");
    log("Response Json getListTeacher: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success =
          ListTeacherResponseModel.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
