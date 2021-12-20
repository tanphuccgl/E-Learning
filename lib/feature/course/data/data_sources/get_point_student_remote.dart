import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_point_student_res.dart';

import '../../../../main.dart';


abstract class GetPointStudentRemoteDataSource {
  Future<GetPointStudentResponse> getPointStudent(
      String idCourse,int idAccount
      );
}

class GetPointStudentRemoteDataSourceImpl
    implements GetPointStudentRemoteDataSource {
  final http.Client? client;

  GetPointStudentRemoteDataSourceImpl({this.client});

  @override
  Future<GetPointStudentResponse> getPointStudent(
      String idCourse,int idAccount
      ) {
    return _getPointStudent(idCourse,idAccount);
  }

  Future<GetPointStudentResponse> _getPointStudent(
      String idCourse,int idAccount
      ) async {
    final response = await client!.get(
      Uri.parse('$mainUrl/course/GetPointStudent?idCourse=$idCourse&idAccount=$idAccount'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json", // k co header la failed 415
        "auth-token": "${appUser?.token}"
      },
    );

    log("Get GetPointStudentResponse: " +
        '$mainUrl/course/GetPointStudent?idCourse=$idCourse&idAccount=$idAccount');
    log("Response Json GetPointStudentResponse: ${json.decode(response.body)}");

    if (response.statusCode == 200) {
      var success =
      GetPointStudentResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
