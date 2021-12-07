import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_all_lecture_of_course_res.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';


abstract class GetAllLectureRemoteDataSource {
  Future<GetAllLectureResponse> getAllLecture(String idCourse );
}

class GetAllLectureRemoteDataSourceImpl implements GetAllLectureRemoteDataSource {
  final http.Client? client;

  GetAllLectureRemoteDataSourceImpl({this.client});

  @override
  Future<GetAllLectureResponse> getAllLecture(String idCourse  ) {
    return _getAllLecture(idCourse, );
  }

  Future<GetAllLectureResponse> _getAllLecture(
      String idCourse, ) async {
    final response = await client!.get(
      Uri.parse(
          '$mainUrl/lecture/GetAllLectureOfCourse?idCourse=$idCourse'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json", // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
        "auth-token":"${appUser?.token}"
      },
    );

    log("Get GetAllLectureResponse: " +
        '${response.statusCode}');

    if (response.statusCode == 200) {
      var success = GetAllLectureResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
