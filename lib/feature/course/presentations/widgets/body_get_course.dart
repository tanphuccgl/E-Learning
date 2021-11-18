import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_course_page.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class BodyGetCourse extends StatefulWidget {
  const BodyGetCourse({Key? key}) : super(key: key);

  @override
  _BodyGetCourseState createState() => _BodyGetCourseState();
}

class _BodyGetCourseState extends State<BodyGetCourse> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourseBloc, GetCourseState>(
        builder: (context, state) {
      if (state is Empty) {
        getCourse();
      } else if (state is Loaded) {
        return _listCourse(list: state.data);
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

  Widget _listCourse({List<GetCourseData>? list}) {
    Size size = MediaQuery.of(context).size;

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return true;
      },
      child: Container(
        height: size.width / 0.9,
        width: size.width,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _item(
                nameCourse: list?[index]?.nameCourse,
                idCourse: list?[index]?.idCourse);
          },
          scrollDirection: Axis.vertical,
          itemCount: list?.length,
        ),
      ),
    );
  }

  Widget _item({String? nameCourse, String? idCourse}) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.width / 20),
      child: Container(
          height: size.width / 3,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                .withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(size.width / 30)),
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width / 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _avatar(image: "assets/images/avatar.jpg"),
                    _nameCourse(nameCourse: "6A3 - $nameCourse"),
                    _progress(number: 30),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailCoursePage(
                                    idCourse: idCourse,nameCourse:nameCourse
                                  )));
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      size: size.width / 10,
                    ))
              ],
            ),
          )),
    );
  }

  Widget _avatar({String? image}) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          width: size.width / 20,
          height: size.width / 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(size.width / 30)),
            image: DecorationImage(
              image: AssetImage(image!),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  Widget _nameCourse({String? nameCourse}) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Text(
        nameCourse!,
        style: TextStyle(
            fontSize: size.width / 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    );
  }

  Widget _progress({int? number}) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        LinearPercentIndicator(
          width: size.width / 2.5,
          lineHeight: size.width / 30,
          percent: 0.3,
          backgroundColor: Colors.black26,
          progressColor: Colors.amberAccent,
        ),
        Text("$number% đã hoàn thành"),
      ],
    );
  }

  void getCourse() {
    BlocProvider.of<GetCourseBloc>(context).add(GetCourseEventE(
        idAccount: "idAccount=${appUser?.iId}", keySearchNameCourse: ""));
  }
}
