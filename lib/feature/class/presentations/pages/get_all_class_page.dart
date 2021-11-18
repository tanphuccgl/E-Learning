import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/widgets/body_get_all_class.dart';

class GetAllClassPage extends StatefulWidget {
  static const String routeName = '/GetAllClassPage';
  GetAllClassPage({Key? key}) : super(key: key);

  @override
  _GetAllClassPageState createState() => _GetAllClassPageState();
}

class _GetAllClassPageState extends State<GetAllClassPage> {
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
            "get all class",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BodyGetAllClass());
  }
}
