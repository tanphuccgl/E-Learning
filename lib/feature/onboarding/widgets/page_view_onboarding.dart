import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget pageViewOnboarding(
    {required title,
    required String description,
    required String image,
    required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.all(40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Center(
            child: Text(
              description,
              style: TextStyle(color: Colors.amber, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 40),
          child: Image.asset(
            image,
            width: size.width / 1.2,
            height: size.height / 2.13,
          ),
        )
      ],
    ),
  );
}
