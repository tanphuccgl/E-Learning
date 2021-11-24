import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/data_sources/add_course_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/widgets/body_add_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_title.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_bloc.dart';

class AddCoursePage extends StatefulWidget {
  static const String routeName = "/AddCoursePage";

  AddCoursePage({Key? key}) : super(key: key);

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  TextEditingController? nameCourseController;

  String? nameCourse;
  int? idTeacher;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCourseController = TextEditingController();
    nameCourse = "";
    idTeacher = null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context: context, title: "Create Course"),
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width / 25,
            right: size.width / 25,
          ),
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
              Align(alignment:Alignment.topLeft ,
                child: Text(
                  "Choose teacher",
                  style: TextStyle(
                      fontSize: size.width / 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: size.width/20,),
              buildListTeacher(nameCourse: nameCourse,context: context),

            ],
          ),
        ),
      ),
    );
  }


}

BlocProvider<GetAllTeacherBloc> buildListTeacher({BuildContext? context, String? nameCourse}) {
  return BlocProvider(
      create: (_) => sl<GetAllTeacherBloc>(), child: BodyAddCourse(nameCourse:nameCourse ,));
}
