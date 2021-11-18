import 'dart:convert';

import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/models/login_data.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

LoginData getCurrentUser() {
  final loginResponse = prefs?.getString(SAVE_LOGIN_RESPONSE);
  if (loginResponse != null && loginResponse != '') {
    var response = LoginData.fromJson(json.decode(loginResponse));

    return response;
  } else {
    throw CacheException();
  }
}
