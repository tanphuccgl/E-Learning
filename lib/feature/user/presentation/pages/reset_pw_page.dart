import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_title.dart';
import 'package:thuc_tap_tot_nghiep/feature/password/reset_pw/data/datasources/put_reset_pw.dart';

class ResetPwPage extends StatefulWidget {
  static const String routeName = "/ResetPwPage";
  const ResetPwPage({Key? key}) : super(key: key);

  @override
  _ResetPwPageState createState() => _ResetPwPageState();
}

class _ResetPwPageState extends State<ResetPwPage> {
  final _fullNameController = TextEditingController();

  String? _fullName;

  bool _isChecked = false;
  String dropdownValue = 'Man';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: "Reset Password"),
      body: Container(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width / 25,
            right: size.width / 25,
          ),
          child: Column(
            children: <Widget>[
              inputName(
                  title: "User name",
                  context: context,
                  function: (value) {
                    _fullName = value;
                  },
                  textEditingController: _fullNameController,
                  hintText: "Input user name"),
              SizedBox(
                height: size.width / 20,
              ),
              accept(function: () {}, context: context, content: "Reset"),
            ],
          ),
        ),
      ),
    );
  }
}
