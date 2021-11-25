import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/card_widget.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/pages/create_class_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/pages/get_all_class_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/add_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/edit_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/get_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/remove_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';

class FuncCoursePage extends StatefulWidget {
  static const String routeName = "/FuncCoursePage";

  const FuncCoursePage({Key? key}) : super(key: key);

  @override
  _FuncCoursePageState createState() => _FuncCoursePageState();
}

class _FuncCoursePageState extends State<FuncCoursePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(title: "Course", context: context),
      body: Container(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width / 25,
                right: size.width / 25,
                top: size.width / 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                card(
                    title: "List Course",
                    colorCard: Colors.blue,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetCoursePage()));
                    }),
                card(
                    title: "Create Course",
                    colorCard: Colors.green,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCoursePage()));
                    }),
                card(
                    title: "Edit Course",
                    colorCard: Colors.amber,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditCoursePage()));
                    }),
                card(
                    title: "Remove Course",
                    colorCard: Colors.red,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (_) => sl<GetCourseBloc>(),
                                    child: RemoveCoursePage(),
                                  )));
                    }),
                // _card(title: "Course"),
                // _card(title: "Course"),
                // _card(title: "Course"),
                // _card(title: "Course"),
              ],
            ),
          )),
    );
  }
}
