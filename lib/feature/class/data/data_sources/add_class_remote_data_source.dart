import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';

http.Client? client = http.Client();

Future<bool> addClass({String? nameClass, int? lv,Function? success,Function? failure}) async {
  var body = jsonEncode({'nameClass': nameClass, 'lv': lv});
  final response =
      await client?.post(Uri.parse('$mainUrl/class/AddClass'),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json" // k co header la failed 415
          },
          body: body);
  log("Post AddClass: " + "$mainUrl/class/AddClass");
  log("Post body AddClass: " + body);
  log("Response Json AddClass: ${json.decode(response!.body)}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
