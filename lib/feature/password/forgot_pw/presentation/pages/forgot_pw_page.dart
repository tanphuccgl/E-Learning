import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/feature/password/forgot_pw/data/datasources/post_forgot_pw.dart';
import 'package:thuc_tap_tot_nghiep/feature/password/forgot_pw/presentation/pages/set_new_pw_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = '/ForgotPasswordPage';

  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  String? _email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            /// back ground
            Container(
              height: size.height,
              decoration: BoxDecoration(color: Colors.blue),
              child: Image.asset(
                "assets/images/banner-wap.jpg",
                fit: BoxFit.fitHeight,
              ),
            ),

            /// làm mờ ảnh
            ClipRRect(
              // Clip it cleanly.
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  color: Colors.grey.withOpacity(0.001),
                  alignment: Alignment.center,
                ),
              ),
            ),

            /// appBar
            Padding(
              padding: EdgeInsets.all(size.width / 30),
              child: Container(
                width: size.width,
                height: size.width / 5,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          iconBack,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: size.width / 6,
                    ),
                    Text(
                      "Forgot Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width / 20,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height / 4, horizontal: size.width / 15),
              child: Container(
                height: size.height - size.height / 6,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ///nhập mail
                      Container(
                        height: size.height / 12.8,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Email'),
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                      ),

                      SizedBox(
                        height: size.width / 20,
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width / 30))),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_email == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Email is Invalid')));
                              } else {
                                postForgotPw(
                                    email: _email,
                                    failure: () => showCancel(),
                                    success: () => showSuccess(email: _email));
                              }
                            },
                            child: Text("Continue")),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void showCancel() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Can't search email");
  }

  void showSuccess({String? email}) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SetNewPasswordPage(email: email,)));
  }
}
