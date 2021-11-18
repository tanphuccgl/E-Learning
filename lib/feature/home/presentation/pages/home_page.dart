import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/config/size.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/get_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/widgets/content_widget.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/widgets/filter_widget.dart';
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width / 25,
                right: size.width / 25,
                top: size.width / 10),
            child: Column(
              children: [
                header(context: context),
                filter(context: context),
                content(title: "Popular courses", context: context),
                GetCoursePage(),

              ],
            ),
          ),
        ));
  }
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
