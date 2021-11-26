import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/config/get_current_user.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/presentations/manager/login_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/presentations/manager/login_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/presentations/manager/login_state.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class BodyLogin extends StatefulWidget {
  BodyLogin({Key? key}) : super(key: key);

  @override
  BodyLoginState createState() => BodyLoginState();
}

class BodyLoginState extends State<BodyLogin> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  String? _email;
  String? _pass;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is Empty) {
        isLogin();
      } else if (state is LoginAlready) {
        appUser = getCurrentUser();

        inHome();
      } else if (state is Loaded) {
        appUser = state.data;
        inHome();
      } else if (state is Loading) {
        return SpinkitLoading();
      } else if (state is Error) {
        return _body(widget: _failed());
      } else if (state is NotLogin) {
        return _body(widget: SizedBox.shrink());
      }
      return Container();
    });
  }

  Widget _body({Widget? widget}) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          /// back ground
          Container(
            height: size.height / 5,
            decoration: BoxDecoration(color: Colors.blue),
            child: Image.asset(
              imageBanner,
              fit: BoxFit.fitHeight,
            ),
          ),

          /// làm mờ ảnh
          ClipRRect(
            // Clip it cleanly.
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.grey.withOpacity(0.001),
                alignment: Alignment.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height / 6),
            child: Container(
              height: size.height - size.height / 6,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 10),
                child: Column(
                  children: <Widget>[
                    /// logo
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size.width / 10),
                      child: Container(
                        height: size.width / 2,
                        width: size.width / 2,
                        child: Image.asset(
                          imageLogo,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    ///nhập mail
                    Container(
                      height: size.height / 12.8,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                        onChanged: (value) {
                          clear;
                          _email = value;
                        },
                      ),
                    ),

                    /// nhập pass
                    Container(
                      height: size.height / 12.8,
                      child: TextFormField(
                        controller: _passController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(labelText: 'Password'),
                        onChanged: (value) {
                          clear;
                          _pass = value;
                        },
                      ),
                    ),

                    /// _failed(),
                    widget!,
                    SizedBox(
                      height: size.width / 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        /// nhớ tài khoản
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                              checkColor: Colors.white,
                            ),
                            Text(
                              "Remember me",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),

                        /// quên mật khẩu
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PageRoutes.forgotPasswordPage);
                          },
                          child: Text("Forgot Password"),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width / 15,
                    ),

                    /// button dan nhap

                    Container(
                      width: size.width / 3,
                      height: size.width / 9,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue,
                                offset: Offset(0, 4),
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                          borderRadius:
                              BorderRadius.all(Radius.circular(size.width / 30))),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_email != null && _pass != null) {
                              return login();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Email or password is Invalid')));

                              return clear();
                            }
                          },
                          child: Text("Sign In")),
                    ),

                    /// đăng nhập bằng face hoặc google
                    // Text("Or"),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Icon(Icons.face),
                    //     SizedBox(
                    //       width: size.width / 100,
                    //     ),
                    //     Icon(Icons.g_mobiledata)
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// hàm đến trang home - no back
  void inHome() {
    Future.delayed(Duration.zero, () async {
      Navigator.pushNamedAndRemoveUntil(
          context, PageRoutes.homePage, (Route<dynamic> route) => false);
    });
  }

  void login() {
    BlocProvider.of<LoginBloc>(context).add(LoginE(_email!, _pass!));
  }

  void isLogin() {
    BlocProvider.of<LoginBloc>(context).add(IsLogin());
  }

  void clear() {
    BlocProvider.of<LoginBloc>(context).add(ClearE());
  }
}

Widget _failed() {
  return Container(
    child: Row(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Login failed. Email or password does not match!",
              style: TextStyle(color: Colors.red, fontSize: 12),
            ))
      ],
    ),
  );
}
