import 'package:flutter/material.dart';

class DashBoard {
  String? title;
  int? count;
  Icon? icon;
  DashBoard({this.icon, this.count, this.title});
}
// DashBoard item= DashBoard(title: ,icon: ,count: );

List<DashBoard> listDashBoard = [];
