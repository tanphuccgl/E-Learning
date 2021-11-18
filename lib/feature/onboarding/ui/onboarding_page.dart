import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';

class OnBoardingPage extends StatefulWidget {
  static const String routeName = '/OnBoardingPage';

  OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Padding(
        padding: EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: <Widget>[
            Container(
              height: size.height / 2,
            ),
            Container(
              height: size.height / 2,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      "Welcome to Dislearn",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Text(
                      "ofweorif fsdlnfnd weripewipo kjsad fksd,fnlsd wpoieruew",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      child: Text("SIGN IN"),
                      style: ElevatedButton.styleFrom(fixedSize: Size(120, 40)),
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutes.signInPage);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      child: Text("SIGN UP"),
                      style: ElevatedButton.styleFrom(fixedSize: Size(120, 40)),
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutes.signUpPage);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
