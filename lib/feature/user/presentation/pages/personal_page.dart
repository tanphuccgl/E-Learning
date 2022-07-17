import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/widgets/bottom_navi_bar_cus.dart';
import 'package:thuc_tap_tot_nghiep/feature/password/change_pw/presentation/pages/change_pw_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/pages/change_info_user_page.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class PersonalPage extends StatefulWidget {
  static const String routeName = "/PersonalPage";

  const PersonalPage({Key? key}) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        index: appUser?.role == "admin" ? 2 : 1,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: EdgeInsets.all(size.width / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.width / 20,
              ),
              Container(
                width: size.width / 5,
                height: size.width / 5,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/avatar.jpg",
                  ),
                ),
              ),
              SizedBox(
                height: size.width / 20,
              ),
              // _item(
              //     title: "Infomation",
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => ChangeInfoUserPage()));
              //     }),
              _item(
                  title: "Change password",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordPage()));
                  }),
              _item(
                  title: "Log out",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => new AlertDialog(
                        title: new Text('Quit?'),
                        content: new Text('Do you really want logout?'),
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () {
                              prefs!.setString(SAVE_LOGIN_RESPONSE, '');

                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  PageRoutes.signInPage,
                                  (Route<dynamic> route) => false);
                            },
                            child: new Text('Yes'),
                          ),
                          new FlatButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: new Text('No'),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item({String? title, Function()? onPressed}) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        height: size.height / 9,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 4),
                  blurRadius: 0.9,
                  spreadRadius: 1),
            ],
            borderRadius: BorderRadius.all(Radius.circular(size.width / 20))),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width / 25,
                    fontWeight: FontWeight.w500),
              ),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.arrow_forward_ios_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
