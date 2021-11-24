import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';

class BodyGetAllCourse extends StatefulWidget {
  const BodyGetAllCourse({Key? key}) : super(key: key);

  @override
  _BodyGetAllCourseState createState() => _BodyGetAllCourseState();
}

class _BodyGetAllCourseState extends State<BodyGetAllCourse> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourseBloc, GetCourseState>(
        builder: (context, state) {
      if (state is Empty) {
        BlocProvider.of<GetCourseBloc>(context)
            .add(GetCourseEventE(idAccount: "", keySearchNameCourse: ""));
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
                    width: size.width / 6,
                  ),
                  Text("Name Course"),
                  SizedBox(
                    width: size.width / 5,
                  ),
                  Text("Teacher")
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
                      return _item(data: list?[index], number: index + 1);
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

  Widget _item({GetCourseData? data, int? number}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.width / 8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("$number"),
          SizedBox(
            width: size.width / 5,
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
          )
        ],
      ),
    );
  }
}
