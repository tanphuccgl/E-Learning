import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_id_account_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_grade_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

abstract class GetGradeExerciseRemoteDataSource {
  Future<GetGradeExerciseResponse> getGradeExercise(
      int idExercise, String idCourse);
}

class GetGradeExerciseRemoteDataSourceImpl
    implements GetGradeExerciseRemoteDataSource {
  final http.Client? client;

  GetGradeExerciseRemoteDataSourceImpl({@required this.client});

  @override
  Future<GetGradeExerciseResponse> getGradeExercise(
      int idExercise, String idCourse) {
    return _getGradeExercise(idExercise, idCourse);
  }

  Future<GetGradeExerciseResponse> _getGradeExercise(
      int idExercise, String idCourse) async {
    final response = await client?.get(
      Uri.parse(
          '$mainUrl/exercise/GetGradeExercise?idCourse=$idCourse&idExercise=$idExercise'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json", // k co header la failed 415
        "auth-token": "${appUser?.token}",
      },
    );
    log("Get GetGradeExercise: " +
        "$mainUrl/exercise/GetGradeExercise?idCourse=$idCourse&idExercise=$idExercise");
    log("Response Json GetGradeExercise: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success =
          GetGradeExerciseResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
