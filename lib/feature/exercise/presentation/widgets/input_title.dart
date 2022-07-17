import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget inputName(
    {String? title,
    TextEditingController? textEditingController,
    Function(String)? function,
    String? hintText,
    BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;

  return Container(
    height: size.width / 4.7,
    width: size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: size.width / 20),
        ),
        TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.width / 30),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.width / 30),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
          ),
          onChanged: function,
          controller: textEditingController,
        ),
      ],
    ),
  );
}
