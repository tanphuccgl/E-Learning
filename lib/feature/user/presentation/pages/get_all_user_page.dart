import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_studen_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_teacher_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_student/get_all_student_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_student/get_all_student_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_student/get_all_student_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_state.dart';

class GetAllUserPage extends StatefulWidget {
  final bool? teacherPage;
  static const String routeName = "/GetAllUserPage";

  const GetAllUserPage({Key? key, this.teacherPage}) : super(key: key);

  @override
  _GetAllUserPageState createState() => _GetAllUserPageState();
}

class _GetAllUserPageState extends State<GetAllUserPage> {
  @override
  Widget build(BuildContext context) {
    return widget.teacherPage == true
        ?

        /// page list all teacher
        BlocProvider(
            create: (_) => sl<GetAllTeacherBloc>(),
            child: BlocBuilder<GetAllTeacherBloc, GetAllTeacherState>(
                builder: (context, state) {
              if (state is Empty) {
                BlocProvider.of<GetAllTeacherBloc>(context)
                    .add(GetAllTeacherE());
              } else if (state is Loaded) {
                return Scaffold(
                    appBar: appBar(context: context, title: "List Teacher"),
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
          )
        :

        ///page list all student
        BlocProvider(
            create: (_) => sl<GetAllStudentBloc>(),
            child: BlocBuilder<GetAllStudentBloc, GetAllStudentState>(
                builder: (context, state) {
              if (state is Empty1) {
                BlocProvider.of<GetAllStudentBloc>(context)
                    .add(GetAllStudentE());
              } else if (state is Loaded1) {
                return Scaffold(
                    appBar: appBar(context: context, title: "List Teacher"),
                    body: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: _list1(list: state.data),
                      ),
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
          );
  }

  Widget _list({List<GetAllTeacherData>? list}) {
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
                      );
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

  Widget _item({GetAllTeacherData? data, int? number}) {
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
            child: Text(data!.username!),
            width: size.width / 4,
          ),
          Container(
            child: Text(data.fullName!),
            width: size.width / 10,
          ),
        ],
      ),
    );
  }

  Widget _list1({List<GetAllStudentData>? list}) {
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
              height: size.width / 0.65,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return _item1(
                        data: list?[index],
                        number: index + 1,
                      );
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

  Widget _item1({GetAllStudentData? data, int? number}) {
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
            child: Text(data!.username!),
            width: size.width / 4,
          ),
          Container(
            child: Text(data.fullName!),
            width: size.width / 10,
          ),
        ],
      ),
    );
  }
}
