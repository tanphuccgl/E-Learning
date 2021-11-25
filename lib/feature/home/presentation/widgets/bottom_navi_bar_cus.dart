import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int? index;

  const CustomBottomNavigationBar({Key? key, this.index}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
            context, PageRoutes.homePage, (Route<dynamic> route) => false);

        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(
            context, PageRoutes.notifiPage, (Route<dynamic> route) => false);

        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(
            context, PageRoutes.personalPage, (Route<dynamic> route) => false);

        break;
      case 3:
      // Navigator.pushNamedAndRemoveUntil(
      //     context, PageRoutes.historyPage, (Route<dynamic> route) => false);

        break;
      case 4:
      // showDialog(
      //   context: context,
      //   builder: (context) => new AlertDialog(
      //     title: new Text('Quit?'),
      //     content: new Text('Do you really want logout?'),
      //     actions: <Widget>[
      //       new FlatButton(
      //         onPressed: () {
      //           prefs!.setString(SAVE_LOGIN_RESPONSE, '');
      //
      //           Navigator.pushNamedAndRemoveUntil(context,
      //               PageRoutes.loginPage, (Route<dynamic> route) => false);
      //         },
      //         child: new Text('Yes'),
      //       ),
      //       new FlatButton(
      //         onPressed: () => Navigator.of(context).pop(false),
      //         child: new Text('No'),
      //       ),
      //     ],
      //   ),
      // );

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(239, 241, 244, 1),
              spreadRadius: 1,
              offset: Offset(0, -4),
              blurRadius: 20),
        ],
      ),
      child: ClipRRect(
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: ('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: ('Notification')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: ("Personal")),
            // BottomNavigationBarItem(
            //     icon: Image.asset("assets/icons/Messages, Chat.png"),
            //     label: ('Messages')),
            // BottomNavigationBarItem(
            //     icon: Image.asset("assets/icons/setting4.png"),
            //     label: ('Settings')),
          ],
          currentIndex: widget.index ?? selectedIndex,
          selectedItemColor: Colors.black,
          onTap: onItemTapped,
          backgroundColor: Colors.white,
          unselectedItemColor: HexColor("#949BA5"),enableFeedback: false,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(color: HexColor("#212226")),
          unselectedLabelStyle: TextStyle(color: HexColor("#949BA5")),
        ),
      ),
    );
  }
}