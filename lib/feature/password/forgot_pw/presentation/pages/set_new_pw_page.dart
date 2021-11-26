import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';

class SetNewPasswordPage extends StatefulWidget {
  static const String routeName = '/SetNewPasswordPage';
  SetNewPasswordPage({Key? key}) : super(key: key);

  @override
  _SetNewPasswordPageState createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  final _newPasswordController = TextEditingController();
  final _codeController = TextEditingController();
  String? _newPassword;
  String? _code;
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
                          controller: _codeController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Code'),
                          onChanged: (value) {
                            _code = value;
                          },
                        ),
                      ),  Container(
                        height: size.height / 12.8,
                        child: TextFormField(
                          controller: _newPasswordController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'New Password'),
                          onChanged: (value) {
                            _newPassword = value;
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
                              if (_newPassword == null || _code==null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Code or New password is Invalid')));
                              } else {
                                // Navigator.pushNamed(
                                //     context, PageRoutes.setNewPasswordPage);
                              }
                            },
                            child: Text("Accept")),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}