

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Widget accpect({ Function()? function,BuildContext? context,String? content}) {
  Size size = MediaQuery.of(context!).size;

  return Center(
    child: Padding(
      padding: EdgeInsets.only(top: size.width / 20),
      child: Container(
        height: size.width / 10,
        width: size.width / 4,
        child: ElevatedButton(
          onPressed: function,
          child: Text(content!),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
        ),
      ),
    ),
  );
}