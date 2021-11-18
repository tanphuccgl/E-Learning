import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/widgets/body_add_class.dart';

class AddClassPage extends StatefulWidget {
  static const String routeName = "/AddClassPage";
  AddClassPage({Key? key}) : super(key: key);

  @override
  _AddClassPageState createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Add Class",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BodyAddClass());
  }
}
