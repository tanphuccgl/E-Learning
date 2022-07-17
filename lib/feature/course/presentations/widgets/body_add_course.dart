import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/data_sources/add_course_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/func_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_teacher_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_state.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class BodyAddCourse extends StatefulWidget {
  final String? nameCourse;

  const BodyAddCourse({Key? key, this.nameCourse}) : super(key: key);

  @override
  _BodyAddCourseState createState() => _BodyAddCourseState();
}

class _BodyAddCourseState extends State<BodyAddCourse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefs?.remove("idCourse");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<GetAllTeacherBloc, GetAllTeacherState>(
        builder: (context, state) {
      if (state is Empty) {
        getAllTeacher();
      } else if (state is Loaded) {
        return Column(
          children: [
            _dropdown(
              list: state.data,
            ),
          ],
        );
      } else if (state is Loading) {
        return SpinkitLoading();
      } else if (state is Error) {
        return Center(
          child: Text("Lỗi hệ thống"),
        );
      }
      return Container();
    });
  }

  Widget _dropdown({
    List<GetAllTeacherData>? list,
  }) {
    Size size = MediaQuery.of(context).size;
    int? id;
    String? a;
    // prefs?.remove("idTeacher");
    // prefs?.remove("nameTeacher");

    if (prefs?.get("idTeacher") == null) {
      a = list![0].fullName;
      id = list[0].iId;
    } else {
      a = prefs?.get("nameTeacher").toString();
      id = prefs?.get("idTeacher") as int?;
    }

    return Column(
      children: [
        Container(
            width: size.width / 2,
            height: size.width / 5,
            child: InputDecorator(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width / 24),
                      borderSide: BorderSide(color: Colors.grey, width: 50))),
              child: StatefulBuilder(builder: (context, setState) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    menuMaxHeight: 300,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: size.width / 10,
                    ),
                    underline: SizedBox(),
                    alignment: AlignmentDirectional.center,
                    value: a,
                    iconSize: 24,
                    elevation: 30,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    onChanged: (String? newValue) {
                      setState(() {
                        a = newValue!;
                      });
                      for (var f in list!) {
                        if (a == f.fullName) {
                          id = f.iId;
                        }
                      }
                      prefs?.setString("nameTeacher", a!);
                      prefs?.setInt("idTeacher", id!);
                    },
                    items: list!.map<DropdownMenuItem<String>>(
                        (GetAllTeacherData value) {
                      return DropdownMenuItem<String>(
                        value: value.fullName,
                        child: Text("${value.fullName}"),
                      );
                    }).toList(),
                  ),
                );
              }),
            )),
        SizedBox(
          height: size.width / 20,
        ),
        accept(
            context: context,
            content: "Create",
            function: () {
              if (widget.nameCourse?.trim().length == 0 ||
                  widget.nameCourse == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Input Name"),
                ));
              } else {
                print(id);
                print(widget.nameCourse);
                addCourse(
                    nameCourse: widget.nameCourse,
                    idTeacher: id,
                    failure: () => showCancel(),
                    success: () => showSuccess());
              }
            }),
      ],
    );
  }

  void showCancel() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Create course failed");
  }

  void showSuccess() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FuncCoursePage()));
        },
        title: "SUCCESS",
        description: "Successful create course");
  }

  void getAllTeacher() {
    BlocProvider.of<GetAllTeacherBloc>(context).add(GetAllTeacherE());
  }
}
