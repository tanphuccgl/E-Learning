import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/card_widget.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/pages/create_class_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';

class FuncClassPage extends StatefulWidget {
  static const String routeName = "/FuncClassPage";

  const FuncClassPage({Key? key}) : super(key: key);

  @override
  _FuncClassPageState createState() => _FuncClassPageState();
}

class _FuncClassPageState extends State<FuncClassPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(title: "Class", context: context),
      body: Container(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width / 25,
                right: size.width / 25,
                top: size.width / 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                card(
                    title: "List Class",
                    colorCard: Colors.blue,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateClassPage()));
                    }),
                card(
                    title: "Create Class",
                    colorCard: Colors.green,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateClassPage()));
                    }),
                card(
                    title: "Edit Class",
                    colorCard: Colors.amber,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateClassPage()));
                    }),
                card(
                    title: "Remove Class",
                    colorCard: Colors.red,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateClassPage()));
                    }),
                // _card(title: "Class"),
                // _card(title: "Class"),
                // _card(title: "Class"),
                // _card(title: "Class"),
              ],
            ),
          )),
    );
  }
}
