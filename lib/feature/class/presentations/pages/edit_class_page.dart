import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_title.dart';

class EditClassPage extends StatefulWidget {
  static const String routeName="/EditClassPage";
  const EditClassPage({Key? key}) : super(key: key);

  @override
  _EditClassPageState createState() => _EditClassPageState();
}

class _EditClassPageState extends State<EditClassPage> {
  TextEditingController? nameCourseController;

  String? nameCourse;
  int? idTeacher;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCourseController = TextEditingController();
    nameCourse = "";
    idTeacher = null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context: context, title: "Edit Class"),
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width / 25,
            right: size.width / 25,
          ),
          child: Column(
            children: <Widget>[
              inputName(
                  title: "Name Class",
                  context: context,
                  function: (value) {
                    nameCourse = value;
                  },
                  textEditingController: nameCourseController,
                  hintText: "Input name"),
              SizedBox(
                height: size.width / 20,
              ),
              accept(context: context,function: (){},content: "Change"),

            ],
          ),
        ),
      ),
    );
  }


}