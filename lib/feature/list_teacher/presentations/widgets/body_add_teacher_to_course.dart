import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/data/models/list_teacher_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/presentations/manager/list_teacher_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/presentations/manager/list_teacher_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/presentations/manager/list_teacher_state.dart';

class BodyAddTeacherToCourse extends StatefulWidget {
  static const String routeName = "/BodyAddTeacherToCourse";
  BodyAddTeacherToCourse({Key? key}) : super(key: key);

  @override
  _BodyAddTeacherToCourseState createState() => _BodyAddTeacherToCourseState();
}

class _BodyAddTeacherToCourseState extends State<BodyAddTeacherToCourse> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ListTeacherBloc, ListTeacherState>(
      builder: (context, state) {
        if (state is Empty) {
          getListTeacher();
        } else if (state is Loading) {
          return SpinkitLoading();
        } else if (state is Loaded) {
          List<Data>? a = state.data!.toList();
          List<bool> b = [];

          return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 50,
                  width: 360,
                  child: Container(
                    child: CheckboxListTile(
                      title: Text('${a[index].fullName}'),
                      secondary: const Icon(Icons.code),
                      autofocus: false,
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      selected: _value,
                      value: _value,
                      onChanged: (bool? value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemCount: state.data!.length);
        } else if (state is Error) {
          return Container(
            child: Text("loi roi ba"),
          );
        }
        return Container();
      },
    );
  }

  void getListTeacher() {
    BlocProvider.of<ListTeacherBloc>(context).add(GetListTeacherE());
  }
}
