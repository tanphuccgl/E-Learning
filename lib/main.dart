import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/pages/add_class_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/add_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_exercise_page.dart';

import 'package:thuc_tap_tot_nghiep/feature/home/presentation/pages/home_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/presentations/pages/add_teacher_to_course_page_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/presentations/widgets/body_add_teacher_to_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/onboarding/ui/onboarding_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/onboarding/ui/onboarding_screen.dart';
import 'package:thuc_tap_tot_nghiep/feature/password/forgot_pw/presentation/pages/forgot_pw_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/password/forgot_pw/presentation/pages/set_new_pw_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/models/login_data.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/presentations/pages/sign_in_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_up/presentation/pages/sign_up_page.dart';
import 'core/config/injection_container.dart' as di;
import 'feature/exercise/presentation/pages/create_exercise_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

SharedPreferences? prefs;
LoginData? appUser;

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
      //  initialRoute: widget.initScreen ==0 || widget.initScreen==null ?? ,
      routes: {
        PageRoutes.onBoardingPage: (context) => OnBoardingPage(),
        PageRoutes.onBoardingScreen: (context) => OnBoardingScreen(),
        PageRoutes.signInPage: (context) => SignInPage(),
        PageRoutes.forgotPasswordPage: (context) => ForgotPasswordPage(),
        PageRoutes.setNewPasswordPage: (context) => SetNewPasswordPage(),
        PageRoutes.signUpPage: (context) => SignUpPage(),
        PageRoutes.homePage: (context) => HomePage(),
        PageRoutes.addCoursePage: (context) => AddCoursePage(),
        PageRoutes.addTeacherToCoursePage: (context) =>
            AddTeacherToCoursePage(),
        PageRoutes.bodyAddTeacherToCourse: (context) =>
            BodyAddTeacherToCourse(),
        PageRoutes.addClassPage: (context) => AddClassPage(),
        PageRoutes.detailCoursePage: (context) => DetailCoursePage(),
        PageRoutes.detailExercisePage: (context) => DetailExercisePage(),
        PageRoutes.createExercisePage: (context) => CreateExercisePage(),



      },
    );
  }
}