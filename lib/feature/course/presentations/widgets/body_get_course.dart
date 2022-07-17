
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class BodyGetCourse extends StatefulWidget {
  final String? changeWithPage;
  final bool? showAll;

  const BodyGetCourse({Key? key, this.changeWithPage, this.showAll})
      : super(key: key);

  @override
  _BodyGetCourseState createState() => _BodyGetCourseState();
}

class _BodyGetCourseState extends State<BodyGetCourse> {
  @override
  void initState() {
    super.initState();
    prefs?.remove("idCourse");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourseBloc, GetCourseState>(
        builder: (context, state) {
      if (state is Empty) {
        getCourse();
      } else if (state is Loaded) {
        if (widget.changeWithPage == "GetCoursePage" &&
            widget.showAll == false) {
          return _listCourse(list: state.data);
        } else if (widget.changeWithPage == "CreateExercisePage") {
          return _dropdown(list: state.data);
        } else if (widget.changeWithPage == "GetCoursePage" &&
            widget.showAll == true) {
          return _buildCoursePageShowAll(list: state.data);
        }
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

  Widget _buildCoursePageShowAll({List<GetCourseData>? list}) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(context: context, title: "List Course (${list!.length})"),
      body: Padding(
        padding: EdgeInsets.only(top: size.width / 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: size.width / 0.5,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width / 25,
              right: size.width / 25,
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _item(
                    nameCourse: list[index].nameCourse,
                    idCourse: list[index].idCourse);
              },
              scrollDirection: Axis.vertical,
              itemCount: list.length,
            ),
          ),
        ),
      ),
    );
  }

  /// danh sách khóa học theo id
  Widget _listCourse({List<GetCourseData>? list}) {
    Size size = MediaQuery.of(context).size;

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: size.width / 0.75,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width / 25,
            right: size.width / 25,
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _item(
                  nameCourse: list?[index].nameCourse,
                  idCourse: list?[index].idCourse);
            },
            scrollDirection: Axis.vertical,
            itemCount: 3,
          ),
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
              borderRadius: BorderRadius.all(Radius.circular(size.width / 30)),
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/shutterstock_520698799small-1500x430.png",
                ),
                fit: BoxFit.cover,
              )),
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
                                  idCourse: idCourse, nameCourse: nameCourse)));
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      size: size.width / 10,
                      color: Colors.white,
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
            color: Colors.white,
            shadows: [
              Shadow(color: Colors.black, offset: Offset(0, 0), blurRadius: 10)
            ]),
      ),
    );
  }

  Widget _progress({int? number}) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        LinearPercentIndicator(
          width: size.width / 2.7,
          lineHeight: size.width / 30,
          percent: 0.3,
          backgroundColor: Colors.grey.shade600,
          progressColor: Colors.amberAccent,
        ),
        Text(
          "$number% completed",
          style: TextStyle(
              fontSize: size.width / 25,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                    color: Colors.black, offset: Offset(0, 0), blurRadius: 30)
              ]),
        ),
      ],
    );
  }

  void getCourse() {
    BlocProvider.of<GetCourseBloc>(context).add(GetCourseEventE(
        idAccount: "?idAccount=${appUser?.iId}", keySearchNameCourse: ""));
  }

  /// drop down get course
  Widget _dropdown({List<GetCourseData>? list}) {
    Size size = MediaQuery.of(context).size;
    String? b;
    String? a;

    if (prefs?.get("idCourse") == null) {
      a = list![0].nameCourse;
      b = list[0].idCourse;
    } else {
      a = prefs?.get("nameCourse").toString();
      b = prefs?.get("idCourse").toString();
    }

    return Container(
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
                    if (a == f.nameCourse) {
                      b = f.idCourse;
                    }
                  }
                  prefs?.setString("nameCourse", a!);
                  prefs?.setString("idCourse", b!);
                },
                items:
                    list!.map<DropdownMenuItem<String>>((GetCourseData value) {
                  return DropdownMenuItem<String>(
                    value: value.nameCourse,
                    child: Text("${value.nameCourse}"),
                  );
                }).toList(),
              ),
            );
          }),
        ));
  }
}
