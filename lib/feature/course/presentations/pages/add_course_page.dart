import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_title.dart';

class AddCoursePage extends StatefulWidget {
  static const String routeName = "/AddCoursePage";
  AddCoursePage({Key? key}) : super(key: key);

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  TextEditingController? nameCourseController ;
  String? nameCourse;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCourseController = TextEditingController();
    nameCourse="";
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context: context,title: "Create Course"),
      body: Container(
        width: size.width,
        height: size.height,

        child: Padding(
    padding: EdgeInsets.only(
    left: size.width / 25,
    right: size.width / 25,),
          child: Column(
            children: <Widget>[
              inputName(
                  title: "Name Course",
                  context: context,
                  function: (value) {
                    nameCourse = value;
                  },
                  textEditingController: nameCourseController,
                  hintText: "Input name"),
              SizedBox(
                height: size.width / 20,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
