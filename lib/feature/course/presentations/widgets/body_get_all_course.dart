import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/data_sources/add_student_to_course_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_studen_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_student/get_all_student_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_student/get_all_student_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_student/get_all_student_state.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class BodyGetAllCourse extends StatefulWidget {
  const BodyGetAllCourse({Key? key}) : super(key: key);

  @override
  _BodyGetAllCourseState createState() => _BodyGetAllCourseState();
}

class _BodyGetAllCourseState extends State<BodyGetAllCourse> {
  bool? isChoose=false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourseBloc, GetCourseState>(
        builder: (context, state) {
      if (state is Empty) {
        BlocProvider.of<GetCourseBloc>(context).add(
            GetCourseEventE(idAccount: "", keySearchNameCourse: "ForAdmin"));
      } else if (state is Loaded) {
        return Scaffold(
          appBar: appBar(context: context, title: "List Course"),
          body: _list(list: state.data!.reversed.toList()),
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

  Widget _list({List<GetCourseData>? list}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width / 25,
          right: size.width / 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.width / 7,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("No"),
                  SizedBox(
                    width: size.width / 10,
                  ),
                  Text("Name Course"),
                  SizedBox(
                    width: size.width / 8,
                  ),
                  Text("Teacher"),
                  SizedBox(
                    width: size.width / 10,
                  ),
                  Text("Add Student")
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.width / 0.65,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return _item(
                          data: list?[index],
                          number: index + 1,
                          onPressed: () {
                            showDialogListStudent(idCourse: list?[index].idCourse);
                          });
                    },
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                    itemCount: list!.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({GetCourseData? data, int? number, Function()? onPressed}) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailCoursePage(
                    idCourse: data?.idCourse, nameCourse: data?.nameCourse)));
      },
      child: Container(
        width: size.width,
        height: size.width / 8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$number"),
            SizedBox(
              width: size.width / 10,
            ),
            Container(
              child: Text(data!.nameCourse!),
              width: size.width / 4,
            ),
            SizedBox(
              width: size.width / 6,
            ),
            Container(
              child: Text(
                data.fullName!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              width: size.width / 9,
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: onPressed,
              ),
              width: size.width / 4,
            ),
          ],
        ),
      ),
    );
  }

  void showDialogListStudent({String? idCourse}) {
    showDialog(
      context: context,
      builder: (_) {

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text('List Student'),
          content: Builder(builder: (context) {
            var width = MediaQuery.of(context).size.width;
            return Container(
                height: width,
                width: width,
                child: BlocProvider(
                  create: (_) => sl<GetAllStudentBloc>(),
                  child: BlocBuilder<GetAllStudentBloc, GetAllStudentState>(
                      builder: (context, state) {
                    if (state is Empty1) {
                      BlocProvider.of<GetAllStudentBloc>(context)
                          .add(GetAllStudentE());
                    } else if (state is Loaded1) {

                      return Scaffold(
                          body: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: _list1(list: state.data,idCourse: idCourse),
                      ));
                    } else if (state is Loading1) {
                      return SpinkitLoading();
                    } else if (state is Error1) {
                      return Center(
                        child: Text("Lỗi hệ thống"),
                      );
                    }
                    return Container();
                  }),
                ));
          }),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),

          ],
        );
      },
    );
  }
  void showDialogConfirm({String? idCourse}) {
    showDialog(
      context: context,
      builder: (_) {

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text('Add Student'),
          content: Builder(builder: (context) {
            var width = MediaQuery.of(context).size.width;
            return Container(
                height: width/10,
                width: width/5,
                child: Text("Add student ${prefs?.getString("addNameStudent")} to course"));
          }),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addStudentToCourse(idStudent:prefs?.getInt("addIdStudent"),idCourse: idCourse! );
              },
              child: Text('OK'),
            ),

          ],
        );
      },
    );
  }

  Widget _list1({List<GetAllStudentData>? list,String? idCourse}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width / 25,
          right: size.width / 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.width / 7,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("No"),
                  Text("Username"),
                  Text("Full Name"),
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.width - 80,
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return _item1(
                        data: list?[index],
                        number: index + 1,
                        onTap: () {


                          prefs?.remove("addIdStudent");
                          prefs?.remove("addNameStudent");
                          prefs?.setInt("addIdStudent", list![index].iId!);
                          prefs?.setString(
                              "addNameStudent", list![index].fullName!);
                          showDialogConfirm(idCourse: idCourse);
                        });
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                  itemCount: list!.length),
            ),

          ],
        ),
      ),
    );
  }

  Widget _item1({GetAllStudentData? data, int? number, Function()? onTap}) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(onPressed:onTap ,style:ElevatedButton.styleFrom(primary: Colors.transparent),
      child: Container(
        width: size.width,
        height: size.width / 8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$number"),
            Container(
              child: Text(data!.username!),
              width: size.width / 4,
            ),
            Container(
              child: Text(data.fullName!),
              width: size.width / 10,
            ),

          ],
        ),
      ),
    );
  }
}
