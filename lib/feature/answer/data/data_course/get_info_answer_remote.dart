import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/models/get_info_answer_res.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

abstract class GetInformationAnswerRemoteDataSource {
  Future<GetInformationAnswerResponse> getInformationAnswer(
      int idAccount, int idAnswer);
}

class GetInformationAnswerRemoteDataSourceImpl
    implements GetInformationAnswerRemoteDataSource {
  final http.Client? client;

  GetInformationAnswerRemoteDataSourceImpl({@required this.client});

  @override
  Future<GetInformationAnswerResponse> getInformationAnswer(
      int idAccount, int idAnswer) {
    return _getInformationAnswer(idAccount, idAnswer);
  }

  Future<GetInformationAnswerResponse> _getInformationAnswer(
      int idAccount, int idAnswer) async {
    final response = await client?.get(
      Uri.parse(
          '$mainUrl/answer/GetInformationAnswer?idAccount=$idAccount&idAnswer=$idAnswer'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json", // k co header la failed 415
        "auth-token": "${appUser?.token}",
      },
    );
    log("Get GetInformationAnswer: " +
        "$mainUrl/answer/GetInformationAnswer?idAccount=$idAccount&idAnswer=$idAnswer");
    log("Response Json GetInformationAnswer: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success =
          GetInformationAnswerResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
