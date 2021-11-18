import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';

class AddCoursePage extends StatefulWidget {
  static const String routeName = "/AddCoursePage";
  AddCoursePage({Key? key}) : super(key: key);

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  TextEditingController nameCourseController = TextEditingController();
  String? nameCourse;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        title: Text("Add course"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height / 12.8,
              width: size.width / 2,
              child: TextFormField(
                controller: nameCourseController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    icon: Icon(Icons.login), labelText: 'Name Course'),
                onChanged: (value) {
                  nameCourse = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                child: TextButton(
                  child: Text("them giaso vien "),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, PageRoutes.addTeacherToCoursePage);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
