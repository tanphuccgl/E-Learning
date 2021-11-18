import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/presentations/manager/login_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/presentations/widgets/body_login.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/SignInPage';
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Sign In Your Account",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: buildBody(context));
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(create: (_) => sl<LoginBloc>(), child: BodyLogin());
  }
}
