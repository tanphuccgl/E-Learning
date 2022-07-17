import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog2.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/data_sources/remove_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/usecases/get_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class RemoveCoursePage extends StatefulWidget {
  static const String routeName = "/RemoveCoursePage";

  @override
  State<StatefulWidget> createState() {
    return RemoveCoursePageState();
  }
}

class RemoveCoursePageState extends State<RemoveCoursePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetCourseBloc>(),
      child:
          BlocBuilder<GetCourseBloc, GetCourseState>(builder: (context, state) {
        if (state is Empty) {
          BlocProvider.of<GetCourseBloc>(context).add(
              GetCourseEventE(idAccount: "", keySearchNameCourse: "ForAdmin"));
        } else if (state is Loaded) {
          return Scaffold(
              appBar: appBar(context: context, title: "Remove Course"),
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: _list(list: state.data),
                ),
              ));
        } else if (state is Loading) {
          return SpinkitLoading();
        } else if (state is Error) {
          return Center(
            child: Text("Lỗi hệ thống"),
          );
        }
        return Container();
      }),
    );
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("No"),
                  Text("Name Course"),
                  Text("Teacher"),
                  Text("Remove Class")
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
                            AlertDialog2.yesAbortDialog(
                                context: context,
                                title: "REMOVE COURSE",
                                body:
                                    "Are you sure you want to delete course ${list?[index].nameCourse}?",
                                onPressed: () {
                                  removeCourse(
                                      idCourse:
                                          list?[index].idCourse.toString(),
                                      failure: () => showCancelDelete(),
                                      success: () => showSuccessDelete());
                                });
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

  void showCancelDelete() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Course in progress");
  }

  void showSuccessDelete() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RemoveCoursePage()));
        },
        title: "SUCCESS",
        description: "Delete successful");
  }

  Widget _item({GetCourseData? data, int? number, Function()? onPressed}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.width / 8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$number"),
          Container(
            child: Text(data!.nameCourse!),
            width: size.width / 4,
          ),
          Container(
            child: Text(data.fullName!),
            width: size.width / 10,
          ),
          Container(
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.highlight_remove),
            ),
            width: size.width / 5,
          )
        ],
      ),
    );
  }
}
