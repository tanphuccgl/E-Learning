import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_title.dart';
import 'package:thuc_tap_tot_nghiep/feature/password/change_pw/data/data_source/change_pw_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/pages/personal_page.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String routeName = "/ChangePasswordPage";

  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String? pass;
  String? newPass;
  TextEditingController passController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(title: "Change Password", context: context),
      body: Container(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: size.width / 20,
              ),
              inputName(
                  title: "Password current",
                  context: context,
                  function: (value) {
                    pass = value;
                  },
                  textEditingController: passController,
                  hintText: "Input password"),
              SizedBox(
                height: size.width / 20,
              ),
              inputName(
                  title: "New password",
                  context: context,
                  function: (value) {
                    newPass = value;
                  },
                  textEditingController: newPassController,
                  hintText: "Input password"),
              SizedBox(
                height: size.width / 20,
              ),
              accept(
                  function: () {
                    changePassword(
                        password: pass,
                        newpassword: newPass,
                        failure: () => showCancel(),
                        success: () => showSuccess());
                  },
                  context: context,
                  color: Colors.green,
                  content: "Accept"),
            ],
          ),
        ),
      ),
    );
  }

  void showCancel() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: " Change password failed");
  }

  void showSuccess() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PersonalPage()));
        },
        title: "SUCCESS",
        description: "  Change password successfully");
  }
}
