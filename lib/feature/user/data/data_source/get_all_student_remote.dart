import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_studen_res.dart';

abstract class GetAllStudentRemoteDataSource {
  Future<GetAllStudentResponse> getAllStudent();
}

class GetAllStudentRemoteDataSourceImpl
    implements GetAllStudentRemoteDataSource {
  final http.Client? client;

  GetAllStudentRemoteDataSourceImpl({@required this.client});

  @override
  Future<GetAllStudentResponse> getAllStudent() {
    return _getAllStudent();
  }

  Future<GetAllStudentResponse> _getAllStudent() async {
    final response = await client?.get(
      Uri.parse('$mainUrl/account/GetStudent'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
      },
    );
    log("Get GetAllStudent: " + "$mainUrl/account/GetStudent");
    log("Response Json GetAllStudent: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success = GetAllStudentResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
