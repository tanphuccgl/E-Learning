import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thuc_tap_tot_nghiep/feature/onboarding/widgets/page_view_onboarding.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = '/OnBoardingScreen';

  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currenPage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          title: Text("fdsbfk"),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    height: size.height / 1.16,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currenPage = page;
                        });
                      },
                      children: <Widget>[
                        pageViewOnboarding(
                            title: "1",
                            description: "2",
                            image: "assets",
                            context: context),
                        pageViewOnboarding(
                            title: "1",
                            description: "2",
                            image: "assets",
                            context: context),
                        pageViewOnboarding(
                            title: "1",
                            description: "2",
                            image: "assets",
                            context: context),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  _currenPage != _numPages - 1 ? _continuePage() : Text(''),
                ],
              ),
            ),
          ),
        ));
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currenPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8 / 0),
      height: size.height / 80,
      width: size.width / 45,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  Widget _continuePage() {
    Size size = MediaQuery.of(context).size;
    return Expanded(
        child: Align(
      alignment: FractionalOffset.bottomRight,
      child: TextButton(
        onPressed: () {
          _pageController.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Next",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            SizedBox(
              width: size.width / 36,
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.amber,
              size: 30,
            )
          ],
        ),
      ),
    ));
  }
}
