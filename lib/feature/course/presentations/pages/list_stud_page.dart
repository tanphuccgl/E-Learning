import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_state.dart';

class ListStudentPage extends StatefulWidget {
  final String? idCourse;

  const ListStudentPage({Key? key, this.idCourse}) : super(key: key);

  @override
  _ListStudentPageState createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMemberInCourseBloc, GetMemberInCourseState>(
        builder: (context, state) {
      if (state is Empty) {
        getMember();
      } else if (state is Loaded) {
        return state.data!.isNotEmpty
            ? _list(data: state.data)
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

  Widget _list({List<GetMemberInCourseData>? data}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height / 1.23,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(
            left: size.width / 25,
            right: size.width / 25,
            top: size.width / 20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return _item(
                  name: "${data?[index]?.role} - ${data?[index]?.fullName}",
                  image: "assets/images/avatar.jpg");
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: data!.length),
      ),
    );
  }

  Widget _item({String? name, String? image}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 6,
      width: size.width,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade500),
        color: Colors.grey.shade300.withOpacity(0.3),
        borderRadius: BorderRadius.all(
          Radius.circular(size.width / 20),

        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: size.width / 50,bottom: size.width / 50,left: size.width / 20,right: size.width / 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width / 7,
              height: size.width / 6,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width / 2)),
                image: DecorationImage(
                  image: AssetImage(image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              name!,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: size.width / 20),
            ),
            SizedBox(width: size.width/4,)
          ],
        ),
      ),
    );
  }

  void getMember() {
    BlocProvider.of<GetMemberInCourseBloc>(context).add(
        GetMemberInCourseEventE(idCourse: widget.idCourse, keySearchName: ""));
  }
}
