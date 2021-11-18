import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';


abstract class GetCourseRemoteDataSource {
  Future<GetCourseResponse> getCourse(String keySearchNameCourse, String idAccount);
}

class GetCourseRemoteDataSourceImpl implements GetCourseRemoteDataSource {
  final http.Client? client;

  GetCourseRemoteDataSourceImpl({this.client});

  @override
  Future<GetCourseResponse> getCourse(String keySearchNameCourse, String idAccount) {
    return _getCourse(keySearchNameCourse, idAccount);
  }

  Future<GetCourseResponse> _getCourse(
      String keySearchNameCourse, String idAccount) async {
    final response = await client!.get(
      Uri.parse(
          '$mainUrl/course/GetCourse?$keySearchNameCourse$idAccount'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    log("Get GetCourseResponse: " +
        "$mainUrl/course/GetCourse?$keySearchNameCourse$idAccount");
    log("Response Json GetCourseResponse: ${json.decode(response.body)}");

    if (response.statusCode == 200) {
      var success = GetCourseResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
