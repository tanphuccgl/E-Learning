import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/core/config/size.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/get_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/manager/get_dashboard/get_dashboard_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/widgets/bottom_navi_bar_cus.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/widgets/content_widget.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/widgets/filter_widget.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/widgets/gridview.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/widgets/header_widget.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class HomePage extends StatefulWidget {
  static const String routerName = "/HomePage";

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CustomBottomNavigationBar(
          index: 0,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: appUser?.role == "admin"
              ? Padding(
                  padding: EdgeInsets.only(
                      left: size.width / 25,
                      right: size.width / 25,
                      top: size.width / 10),
                  child: Column(
                    children: [
                      header(context: context, name: appUser?.fullName),
                      SizedBox(
                        height: size.width / 15,
                      ),
                      buildBody(context),
                    ],
                  ),
                )
              : Container(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width / 25,
                            right: size.width / 25,
                            top: size.width / 10),
                        child: Container(
                          width: size.width,
                          height: size.height / 4,
                          child: Column(
                            children: [
                              header(context: context, name: appUser?.fullName),
                              filter(context: context),
                              content(
                                  title: "Recent courses", context: context),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          width: size.width,
                          height: size.height - size.height / 2.5,
                          child: GetCoursePage(
                            showAll: false,
                          )),
                    ],
                  ),
                ),
        ));
  }
}

BlocProvider<GetDashboardBloc> buildBody(BuildContext context) {
  return BlocProvider(
      create: (_) => sl<GetDashboardBloc>(), child: GridViewWidget());
}

Widget logOut({@required BuildContext? context}) {
  return TextButton(
      onPressed: () {
        prefs!.setString(SAVE_LOGIN_RESPONSE, '');
        Navigator.pushNamedAndRemoveUntil(context!, PageRoutes.onBoardingPage,
            (Route<dynamic> route) => false);
      },
      child: Text('Out'));
}
