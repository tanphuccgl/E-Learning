import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_title.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/SignUpPage';
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _fullNameController = TextEditingController();

  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _fullName;
  String? _email;
  String? _userName;
  String? _password;
  bool _isChecked = false;
  String dropdownValue = 'Man';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: "Register Account"),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width / 25,
              right: size.width / 25,
            ),
            child: Column(
              children: <Widget>[
                inputName(
                    title: "Full name",
                    context: context,
                    function: (value) {
                      _fullName = value;
                    },
                    textEditingController: _fullNameController,
                    hintText: "Input name"),
                SizedBox(
                  height: size.width / 20,
                ),
                // inputName(
                //     title: "Address",
                //     context: context,
                //     function: (value) {
                //       _fullName = value;
                //     },
                //     textEditingController: _fullNameController,
                //     hintText: "Input address"),
                // SizedBox(
                //   height: size.width / 20,
                // ),
                inputName(
                    title: "Email",
                    context: context,
                    function: (value) {
                      _email = value;
                    },
                    textEditingController: _emailController,
                    hintText: "Input email"),
                SizedBox(
                  height: size.width / 20,
                ),
                inputName(
                    title: "Username",
                    context: context,
                    function: (value) {
                      _userName = value;
                    },
                    textEditingController: _userNameController,
                    hintText: "Input username"),
                SizedBox(
                  height: size.width / 20,
                ),
                // inputName(
                //     title: "Phone Number",
                //     context: context,
                //     function: (value) {
                //       _fullName = value;
                //     },
                //     textEditingController: _fullNameController,
                //     hintText: "Input number"),
                // SizedBox(
                //   height: size.width / 20,
                // ),
                // inputName(
                //     title: "Parent Name",
                //     context: context,
                //     function: (value) {
                //       _fullName = value;
                //     },
                //     textEditingController: _fullNameController,
                //     hintText: "Input name"),
                // SizedBox(
                //   height: size.width / 20,
                // ),
                // inputName(
                //     title: "Phone Number Parent",
                //     context: context,
                //     function: (value) {
                //       _fullName = value;
                //     },
                //     textEditingController: _fullNameController,
                //     hintText: "Input number"),
                // SizedBox(
                //   height: size.width / 20,
                // ),
                inputName(
                    title: "Password",
                    context: context,
                    function: (value) {
                      _password = value;
                    },
                    textEditingController: _passwordController,
                    hintText: "Input password"),
                SizedBox(
                  height: size.width / 20,
                ),
                // Row(crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Choose class",
                //       style: TextStyle(
                //           fontSize: size.width / 20,
                //           color: Colors.black,
                //           fontWeight: FontWeight.w600),
                //     ),
                //     TextButton(onPressed: () { print("add"); },
                //     child: Text(
                //       "Add",
                //       style: TextStyle(
                //           fontSize: size.width / 25,
                //           color: Colors.blue,
                //           fontWeight: FontWeight.w600),
                //     ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: size.width/20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _gender(
                        context: context,
                        function: (a) {},
                        typePointValue: "Male"),
                    _role(
                        context: context,
                        function: (a) {},
                        typePointValue: "Teacher")
                  ],
                ),
                accept(function: () {}, context: context, content: "Accept"),
                SizedBox(
                  height: size.width / 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _gender(
      {BuildContext? context,
      String? typePointValue,
      Function(String?)? function}) {
    Size size = MediaQuery.of(context!).size;

    return Container(
      width: size.width / 2.5,
      height: size.width / 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width / 24),
          border: Border.all(color: Colors.grey),
          color: Colors.lightBlueAccent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Sex",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 25,
                  fontWeight: FontWeight.w600)),
          Container(
            width: size.width / 4,
            height: size.width / 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width / 35),
                color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width / 30, right: size.width / 30),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: typePointValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: function,
                  items: <String>['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _role(
      {BuildContext? context,
      String? typePointValue,
      Function(String?)? function}) {
    Size size = MediaQuery.of(context!).size;

    return Container(
      width: size.width / 2.3,
      height: size.width / 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width / 24),
          border: Border.all(color: Colors.grey),
          color: Colors.lightBlueAccent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Role",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 25,
                  fontWeight: FontWeight.w600)),
          Container(
            width: size.width / 3.5,
            height: size.width / 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width / 35),
                color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width / 30, right: size.width / 30),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: typePointValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: function,
                  items: <String>['Teacher', 'Student']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
