import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_course_res.dart';

abstract class GetExerciseByCourseRemoteDataSource {
  Future<GetExerciseByCourseResponse> getExerciseByCourse(String idCourse );
}

class GetExerciseByCourseRemoteDataSourceImpl implements GetExerciseByCourseRemoteDataSource {
  final http.Client? client;

  GetExerciseByCourseRemoteDataSourceImpl({@required this.client});

  @override
  Future<GetExerciseByCourseResponse> getExerciseByCourse(String idCourse) {
    return _getExerciseByCourse(idCourse);
  }

  Future<GetExerciseByCourseResponse> _getExerciseByCourse(String idCourse) async {
    final response = await client?.get(
      Uri.parse('$mainUrl/exercise/GetExerciseByCourse/$idCourse'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
      },
    );
    log("Get GetExerciseByCourse: " + "$mainUrl/exercise/GetExerciseByCourse/$idCourse");
    log("Response Json GetExerciseByCourse: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success =
      GetExerciseByCourseResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
