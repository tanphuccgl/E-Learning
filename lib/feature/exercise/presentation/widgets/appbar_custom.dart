import 'package:flutter/material.dart';

AppBar appBar({String? title, BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;

  return AppBar(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    title: Text(
      title!,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: size.width / 20),
    ),
    centerTitle: true,
    elevation: 0,
  );
}
