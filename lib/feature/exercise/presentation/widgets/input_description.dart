import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget inputDescription(
    {String? title,
    bool? enabled,
    BuildContext? context,
    TextEditingController? textEditingController,
    Function(String)? function}) {
  Size size = MediaQuery.of(context!).size;

  return Container(
    height: size.width / 1.7,
    width: size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: TextStyle(
              color: Colors.black,
              fontSize: size.width / 20,
              fontWeight: FontWeight.w600),
        ),
        Container(
          height: size.width / 2,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(size.width / 30),
              ),
              border: Border.all(color: Colors.grey, width: 2.0)),
          child: Padding(
            padding: EdgeInsets.all(size.width / 25),
            child: SingleChildScrollView(
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(700),
                ],
                maxLines: 20,
                enabled: enabled,
                decoration: InputDecoration(
                  hintText: "Input description",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Colors.white,
                ),
                onChanged: function,
                controller: textEditingController,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
