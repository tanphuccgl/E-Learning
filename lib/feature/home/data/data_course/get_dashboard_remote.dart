import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/data/models/get_dashboard_res.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

abstract class GetDashboardRemoteDataSource {
  Future<GetDashboardResponse> getDashboard();
}

class GetDashboardRemoteDataSourceImpl implements GetDashboardRemoteDataSource {
  final http.Client? client;

  GetDashboardRemoteDataSourceImpl({@required this.client});

  @override
  Future<GetDashboardResponse> getDashboard() {
    return _getDashboard();
  }

  Future<GetDashboardResponse> _getDashboard() async {
    final response = await client?.get(
      Uri.parse('$mainUrl/admin/Dashboard'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "auth-token": "${appUser?.token}" // k co header la failed 415
      },
    );
    log("Get GetDashboard: " + "$mainUrl/admin/Dashboard");
    log("Response Json GetDashboard: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success = GetDashboardResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
