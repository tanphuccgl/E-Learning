import 'package:flutter/material.dart';

class SetNewPasswordPage extends StatefulWidget {
  static const String routeName = '/SetNewPasswordPage';
  SetNewPasswordPage({Key? key}) : super(key: key);

  @override
  _SetNewPasswordPageState createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  String? _newPassword;
  String? _confirmNewPassword;
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
          "Set New Password",
          style: TextStyle(color: Colors.white),
        ),
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
                      controller: _newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          icon: Icon(Icons.login), labelText: 'New Password'),
                    ),
                  ),
                  Container(
                    height: size.height / 12.8,
                    child: TextFormField(
                      controller: _confirmNewPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          icon: Icon(Icons.password),
                          labelText: 'Confirm New Password'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height / 12.8),
                    child: ElevatedButton(
                        onPressed: () {}, child: Text("Change Password")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
