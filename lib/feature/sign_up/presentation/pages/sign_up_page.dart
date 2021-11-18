import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/SignUpPage';
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firtNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _firtName;
  String? _lastName;
  int? _phoneNumber;
  String? _email;
  String? _userName;
  String? _password;
  String? _confirmPassword;
  bool _isChecked = false;
  String dropdownValue = 'Man';

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
        title: Text("Sign In Your Account"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height / 12.8,
              color: Colors.blue,
            ),
            Container(
              //  height: size.height / 1.254901960784314,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: size.height / 12.8,
                        width: size.width / 2,
                        child: TextFormField(
                          controller: _firtNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              icon: Icon(Icons.login), labelText: 'Firt Name'),
                        ),
                      ),
                      Container(
                        height: size.height / 12.8,
                        width: size.width / 2,
                        child: TextFormField(
                          controller: _lastNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              icon: Icon(Icons.login), labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: size.height / 12.8,
                        width: size.width / 2,
                        child: TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              icon: Icon(Icons.login),
                              labelText: 'Phone Number'),
                        ),
                      ),
                      Container(
                          height: size.height / 12.8,
                          width: size.width / 2,
                          child: DropdownButton<String>(
                            value:
                                dropdownValue.isNotEmpty ? dropdownValue : null,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Man', 'Girl', 'Other']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                  Container(
                    height: size.height / 12.8,
                    width: size.width,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          icon: Icon(Icons.login), labelText: 'Email'),
                    ),
                  ),
                  Container(
                    height: size.height / 12.8,
                    width: size.width,
                    child: TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.login), labelText: 'User Name'),
                    ),
                  ),
                  Container(
                    height: size.height / 12.8,
                    width: size.width,
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.login), labelText: 'Password'),
                    ),
                  ),
                  Container(
                    height: size.height / 12.8,
                    width: size.width,
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.login),
                          labelText: 'Confirm Password'),
                    ),
                  ),
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
                      Text('I accept the'),
                      TextButton(
                          onPressed: () {}, child: Text('Terms and Conditions'))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('SIGN UP'),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width, 40)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
