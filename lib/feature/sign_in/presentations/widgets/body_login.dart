import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/get_current_user.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/pages/home_page.dart';
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
    Size size = MediaQuery.of(context).size;
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
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height / 12.8,
                decoration: BoxDecoration(color: Colors.blue),
              ),
              Container(
                height: size.height - 130,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height / 4.266666666666667,
                    ),
                    Container(
                      height: size.height / 12.8,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            icon: Icon(Icons.login), labelText: 'Email'),
                        onChanged: (value) {
                          clear;
                          _email = value;
                        },
                      ),
                    ),
                    Container(
                      height: size.height / 12.8,
                      child: TextFormField(
                        controller: _passController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            icon: Icon(Icons.password), labelText: 'Password'),
                        onChanged: (value) {
                          clear;
                          _pass = value;
                        },
                      ),
                    ),
                    _failed(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PageRoutes.forgotPasswordPage);
                          },
                          child: Text("Forgot Password"),
                        )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_email != null && _pass != null) {
                            return login();
                          } else {
                            return clear();
                          }
                        },
                        child: Text("SIGN IN")),
                    Text("Or"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.face),
                        SizedBox(
                          width: size.width / 100,
                        ),
                        Icon(Icons.g_mobiledata)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      } else if (state is NotLogin) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height / 12.8,
                decoration: BoxDecoration(color: Colors.blue),
              ),
              Container(
                height: size.height - 130,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height / 4.266666666666667,
                    ),
                    Container(
                      height: size.height / 12.8,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            icon: Icon(Icons.login), labelText: 'Email'),
                        onChanged: (value) {
                          clear;
                          _email = value;
                        },
                      ),
                    ),
                    Container(
                      height: size.height / 12.8,
                      child: TextFormField(
                        controller: _passController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            icon: Icon(Icons.password), labelText: 'Password'),
                        onChanged: (value) {
                          clear;
                          _pass = value;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PageRoutes.forgotPasswordPage);
                          },
                          child: Text("Forgot Password"),
                        )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_email != null && _pass != null) {
                            return login();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(new SnackBar(
                              content: Text('Please complete all information'),
                            ));
                            return clear();
                          }
                        },
                        child: Text("SIGN IN")),
                    Text("Or"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.face),
                        SizedBox(
                          width: size.width / 100,
                        ),
                        Icon(Icons.g_mobiledata)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
      return Container();
    });
  }

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
