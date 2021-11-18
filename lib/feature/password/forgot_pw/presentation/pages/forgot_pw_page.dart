import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Forgot password'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: (size.height / 12.8)),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, PageRoutes.setNewPasswordPage);
                        },
                        child: Text('SEND CODE')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
