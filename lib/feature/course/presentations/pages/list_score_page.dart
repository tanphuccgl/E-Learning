import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_point_student_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_point_student/get_point_student_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_point_student/get_point_student_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_point_student/get_point_student_state.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class Item extends GetPointStudentData {
  Item({
    this.isSelected,
  });

  bool? isSelected;
}

class ListScorePage extends StatefulWidget {
  static const String routeName = "/ListScorePage";
  final String? idCourse;

  const ListScorePage({Key? key, this.idCourse}) : super(key: key);

  @override
  _ListScorePageState createState() => _ListScorePageState();
}

class _ListScorePageState extends State<ListScorePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GetPointStudentBloc, GetPointStudentState>(
        builder: (context, state) {
      if (state is Empty) {
        BlocProvider.of<GetPointStudentBloc>(context).add(GetPointStudentEventE(
            idCourse: widget.idCourse, idAccount: appUser?.iId));
      } else if (state is Loaded) {
        return state.data!.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(
                    top: size.width / 20,
                    left: size.width / 25,
                    right: size.width / 25),
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      child: Row(
                        children: [
                          Text(
                            "No",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 4,
                          ),
                          Text(
                            "Exercise",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 4,
                          ),
                          Text(
                            "Score",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: size.width / 25),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: size.width,
                        height: size.width / 0.7,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return _item(
                                  nameExe: state.data?[index].titleExercise,
                                  score: state.data?[index].studyPoint == null
                                      ? ""
                                      : (state.data?[index].studyPoint
                                          .toString()),
                                  isTextPoint: state.data?[index].isTextPoint,
                                  count: (index + 1).toString());
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: state.data!.length)),
                  ],
                ),
              )
            : Center(child: Text("Invail member"));
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

  Widget _item(
      {String? count, String? nameExe, String? score, int? isTextPoint}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width / 7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(count!),
          SizedBox(
            width: size.width / 4,
          ),
          Text(nameExe!),
          SizedBox(
            width: size.width / 4,
          ),
          isTextPoint == 0
              ? Text(score!)
              : Text(score == "0" ? "Không đạt" : "Đạt"),
        ],
      ),
    );
  }
}
