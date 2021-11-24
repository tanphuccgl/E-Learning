import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/data_sources/add_class_remote_data_source.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_title.dart';

class CreateClassPage extends StatefulWidget {
  static const String routeName = "/CreateClassPage";

  const CreateClassPage({Key? key}) : super(key: key);

  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  TextEditingController? textEditingController;
  String? name;
  int? gradeValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
    name = "";
    gradeValue = 1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: appBar(title: "Create Class", context: context),
        body: Container(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width / 25,
              right: size.width / 25,
            ),
            child: Column(
              children: [
                inputName(
                    title: "Name Class",
                    context: context,
                    function: (value) {
                      name = value;
                    },
                    textEditingController: textEditingController,
                    hintText: "Input name"),
                SizedBox(
                  height: size.width / 20,
                ),
                _gradeClass(
                    function: (int? value) {
                      setState(() {
                        gradeValue = value;
                      });
                    },
                    gradeValue: gradeValue),
                accept(
                    content: "Accept",
                    context: context,
                    function: () {
                      ///check nhập tên bài tập
                      if (name?.trim().length == 0 || name == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Input Name"),
                        ));
                      } else {
                        addClass(
                            nameClass: name,
                            lv: gradeValue,
                            failure: () => showCancel(),
                            success: () => showSuccess());
                      }
                    }),
              ],
            ),
          ),
        ));
  }

  Widget _gradeClass({Function(int?)? function, int? gradeValue}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width / 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Grade Class",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w600)),
          Container(
            width: size.width / 3,
            height: size.width / 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width / 35),
                border: Border.all(color: Colors.grey),
                color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width / 20, right: size.width / 20),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: gradeValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: function,
                  items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCancel() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Create class failed");
  }

  void showSuccess() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => DetailCoursePage(
          //           idCourse: widget.idCourse,
          //           nameCourse: widget.nameCourse,
          //           widgetId: 2,
          //           choosingPos: 2,
          //         )));
        },
        title: "SUCCESS",
        description: "Successful create class");
  }
}
