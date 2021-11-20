import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

Widget header({BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _imageUser(image: 'assets/images/avatar.jpg',context: context),
          SizedBox(
            width: size.width / 20,
          ),
          _nameUser(name: "Julian Torn",context: context)
        ],
      ),
      _noti(context: context),
    ],
  );
}
Widget _noti({BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;

  return GestureDetector(
    onTap: () {
      prefs!.setString(SAVE_LOGIN_RESPONSE, '');
      Navigator.pushNamedAndRemoveUntil(context, PageRoutes.onBoardingPage,
              (Route<dynamic> route) => false);
    },
    child: Container(
      height: size.width / 10,
      width: size.width / 10,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(size.width / 30))),
      child: Icon(
        Icons.notifications_none,
      ),
    ),
  );
}

Widget _nameUser({String? name,BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;

  return Container(
    height: size.width / 7,
    width: size.width / 1.6,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome back,",
          style: TextStyle(
              color: Colors.black,
              fontSize: size.width / 20,
              fontWeight: FontWeight.w600),
        ),
        Text(
          name!,
          style: TextStyle(
              color: Colors.black,
              fontSize: size.width / 15,
              fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget _imageUser({@required String? image,BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;

  return Container(
    width: size.width / 7,
    height: size.width / 7,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(size.width / 30)),
      image: DecorationImage(
        image: AssetImage(image!),
        fit: BoxFit.fill,
      ),
    ),
  );
}