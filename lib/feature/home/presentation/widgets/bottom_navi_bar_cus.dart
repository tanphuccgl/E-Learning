import 'package:flutter/material.dart';
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
            context, PageRoutes.functionPage, (Route<dynamic> route) => false);

        break;
      case 2:
        // Navigator.pushNamedAndRemoveUntil(
        //     context, PageRoutes.checkInPage, (Route<dynamic> route) => false);

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
                color: Colors.black.withOpacity(0.7),
                spreadRadius: 1,
                offset: Offset(-0.1, 0),
                blurRadius: 2),
          ],
      ),
      child: ClipRRect(

        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner), title: Text('Chuc nang')),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code), title: Text('Check In')),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), title: Text('History')),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout), title: Text('Logout')),
          ],
          currentIndex: widget.index ?? selectedIndex,
          selectedItemColor: Colors.black,
          onTap: onItemTapped,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
        ),
      ),
    );
  }
}
