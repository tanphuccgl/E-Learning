import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/get_course_page.dart';

Widget content({String? title,BuildContext? context,Key? key }) {
  Size size = MediaQuery.of(context!).size;

  return Padding(
      padding: EdgeInsets.only(top: size.width / 30),
      child:
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _title(title: title,context: context),
        _showButton(context: context),
      ]));
}

Widget _showButton({BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;

  return TextButton(
      onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCoursePage(showAll: true,)));
      },
      child: Text(
        "Show all",
        style: TextStyle(

            fontSize: size.width / 25,
            fontWeight: FontWeight.w700),
      ));
}

Widget _title({String? title,BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;
  return Text(
    title!,
    style: TextStyle(
      fontSize: size.width / 20,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
  );
}
