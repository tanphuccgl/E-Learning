import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

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
            ? Container(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  appUser?.role == "admin"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            accept(
                                content: "Delete",
                                context: context,
                                function: () {},
                                color: Colors.red),
                            accept(
                                content: "Add",
                                context: context,
                                function: () {},
                                color: Colors.green),
                          ],
                        )
                      : SizedBox.shrink(),
                  _list(data: state.data),
                ],
              ))
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
      height: size.height-size.width/7-size.width/5,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(
            left: size.width / 25,
            right: size.width / 25,
            top: size.width / 20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return _item(
                  name: "${data?[index]?.role}\n${data?[index]?.fullName}",role:data?[index]?.role ,
                  image: "assets/images/avatar.jpg");
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: data!.length),
      ),
    );
  }

  Widget _item({String? name, String? image,String? role}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 6,
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(color:role=="teacher" ?Colors.red.shade500: Colors.green.shade500,width: 2),
        color: Colors.blueGrey.shade100.withOpacity(0.3),
        borderRadius: BorderRadius.all(
          Radius.circular(size.width / 20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: size.width / 50,
            bottom: size.width / 50,
            left: size.width / 20,
            right: size.width / 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width / 7,
              height: size.width / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(size.width / 2)),
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
                  fontWeight: FontWeight.w400,
                  fontSize: size.width / 20),
            ),
            SizedBox(
              width: size.width / 4,
            )
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
