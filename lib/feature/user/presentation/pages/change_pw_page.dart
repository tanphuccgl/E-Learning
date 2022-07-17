import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_title.dart';

class ChangePwPage extends StatefulWidget {
  static const String routeName = "/ChangePwPage";
  const ChangePwPage({Key? key}) : super(key: key);

  @override
  _ChangePwPageState createState() => _ChangePwPageState();
}

class _ChangePwPageState extends State<ChangePwPage> {
  final _fullNameController = TextEditingController();

  String? _fullName;

  bool _isChecked = false;
  String dropdownValue = 'Man';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: "Change Password"),
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
                  title: "Password current",
                  context: context,
                  function: (value) {
                    _fullName = value;
                  },
                  textEditingController: _fullNameController,
                  hintText: "Input password"),
              SizedBox(
                height: size.width / 20,
              ),
              inputName(
                  title: "Password new",
                  context: context,
                  function: (value) {
                    _fullName = value;
                  },
                  textEditingController: _fullNameController,
                  hintText: "Input password"),
              SizedBox(
                height: size.width / 20,
              ),
              accept(function: () {}, context: context, content: "Accept"),
            ],
          ),
        ),
      ),
    );
  }
}
