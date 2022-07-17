import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Widget accept(
    {Function()? function,
    BuildContext? context,
    String? content,
    Color? color = Colors.green}) {
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
            backgroundColor: MaterialStateProperty.all<Color>(color!),
          ),
        ),
      ),
    ),
  );
}

Widget changePage({Function()? function, BuildContext? context, Icon? icon}) {
  Size size = MediaQuery.of(context!).size;

  return Padding(
    padding: EdgeInsets.only(top: size.width / 20),
    child: Container(
      height: size.width / 15,
      width: size.width / 7,
      child: ElevatedButton(
        onPressed: function,
        child: icon,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
    ),
  );
}
