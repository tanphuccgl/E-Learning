import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/utils/dashboard_class.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/data/models/get_dashboard_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/manager/get_dashboard/get_dashboard_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/manager/get_dashboard/get_dashboard_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/manager/get_dashboard/get_dashboard_state.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({Key? key}) : super(key: key);

  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GetDashboardBloc, GetDashboardState>(
      builder: (context, state) {
        if (state is Empty) {
          getGetDashboard();
        } else if (state is Loading) {
          return SpinkitLoading();
        } else if (state is Loaded) {
          return _gridView(data: state.data);
        } else if (state is Error) {
          return Container(
            child: Text("Lỗi hệ thống"),
          );
        }
        return Container();
      },
    );
  }

  Widget _gridView({GetDashboardData? data}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.width / 0.5,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: size.width / 15,
          childAspectRatio: 1,
          mainAxisSpacing: size.width / 15,
          children: [
            _item(
                color: Colors.green,
                count: data?.totalAnswer,
                icon: Icon(Icons.fifteen_mp),
                title: "Total Answer"),
            _item(
                color: Colors.lightBlue,
                count: data?.totalCourse,
                icon: Icon(Icons.fifteen_mp),
                title: "Total Course"),
            _item(
                color: Colors.red,
                count: data?.totalExercise,
                icon: Icon(Icons.fifteen_mp),
                title: "Total Exercise"),
            _item(
                color: Colors.amber,
                count: data?.totalLecture,
                icon: Icon(Icons.fifteen_mp),
                title: "Total Lecture"),
            _item(
                color: Colors.purpleAccent,
                count: data?.totalStudent,
                icon: Icon(Icons.fifteen_mp),
                title: "Total Student"),
            _item(
                color: Colors.pinkAccent,
                count: data?.totalTeacher,
                icon: Icon(Icons.fifteen_mp),
                title: "Total Teacher"),
          ],
        ),
      ),
    );
  }

  Widget _item({Color? color, Icon? icon, String? title, int? count}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 5,
      height: size.width / 5,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(size.width / 20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width / 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              child: icon,
              backgroundColor: Colors.white,
            ),
            Text(
              title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width / 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "${count}",
              style: TextStyle(
                  fontSize: size.width / 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  void getGetDashboard() {
    BlocProvider.of<GetDashboardBloc>(context).add(GetGetDashboardE());
  }
}
