// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AlertDialog1 extends StatelessWidget {
  static const String routeName = '/AlertDialog1';

  final String? title;
  final String? description;
  final Function()? onPressed;
  // final String? image;

  const AlertDialog1({
    Key? key,
    @required this.title,
    @required this.description,
    @required this.onPressed,
    //    @required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 230,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      title!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: size.height / 128,
                    ),
                    Center(
                      child: Text(
                        description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 32,
                    ),
                    RaisedButton(
                      onPressed: onPressed,
                      color: Colors.green,
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Positioned(
            //     top: -60,
            //     child: CircleAvatar(
            //         backgroundColor: kPrimaryWhiteColor,
            //         radius: 60,
            //         child: Image.asset(
            //           "assets/images/${image}.png",
            //           height: size.height/12.8,
            //           width: size.width/7.2,
            //           fit: BoxFit.cover,
            //         ))),
          ],
        ));
  }
}

void showPopup(
    {String? title,
    String? description,
    Function()? function,
    BuildContext? context}) {
  var alert = new AlertDialog1(
    title: title,
    description: description,
    onPressed: function,
  );
  showDialog(
      context: context!,
      builder: (context) {
        return alert;
      });
}
