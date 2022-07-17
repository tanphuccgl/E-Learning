import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_id_account_res.dart';

abstract class GetExerciseByIdAccountRemoteDataSource {
  Future<GetExerciseByIdAccountResponse> getExerciseByIdAccount(int idAccount);
}

class GetExerciseByIdAccountRemoteDataSourceImpl
    implements GetExerciseByIdAccountRemoteDataSource {
  final http.Client? client;

  GetExerciseByIdAccountRemoteDataSourceImpl({@required this.client});

  @override
  Future<GetExerciseByIdAccountResponse> getExerciseByIdAccount(int idAccount) {
    return _getExerciseByIdAccount(idAccount);
  }

  Future<GetExerciseByIdAccountResponse> _getExerciseByIdAccount(
      int idAccount) async {
    final response = await client?.get(
      Uri.parse('$mainUrl/exercise/GetExerciseByIdAccount/$idAccount'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
      },
    );
    log("Get GetExerciseByIdAccount: " +
        "$mainUrl/exercise/GetExerciseByIdAccount/$idAccount");
    log("Response Json GetExerciseByIdAccount: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success =
          GetExerciseByIdAccountResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
