import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';


abstract class GetMemberInCourseRemoteDataSource {
  Future<GetMemberInCourseResponse> getMemberInCourse(String idCourse , String keySearchName);
}

class GetMemberInCourseRemoteDataSourceImpl implements GetMemberInCourseRemoteDataSource {
  final http.Client? client;

  GetMemberInCourseRemoteDataSourceImpl({this.client});

  @override
  Future<GetMemberInCourseResponse> getMemberInCourse(String idCourse, String keySearchName) {
    return _getMemberInCourse(idCourse, keySearchName);
  }

  Future<GetMemberInCourseResponse> _getMemberInCourse(
      String idCourse, String keySearchName) async {
    final response = await client!.get(
      Uri.parse(
          '$mainUrl/course/GetMemberInCourse/$idCourse$keySearchName'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    log("Get GetMemberInCourseResponse: " +
        "$mainUrl/course/GetMemberInCourse/$idCourse$keySearchName");
    log("Response Json GetMemberInCourseResponse: ${json.decode(response.body)}");

    if (response.statusCode == 200) {
      var success = GetMemberInCourseResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
