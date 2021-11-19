import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/widgets/body_get_course.dart';

class CreateExercisePage extends StatefulWidget {
  static const String routeName = "/CreateExercisePage";

  const CreateExercisePage({Key? key}) : super(key: key);

  @override
  _CreateExercisePageState createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {
  TextEditingController? _controller;
  String dropdownValue = 'One';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _controller = TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print("Fadsfas");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: _appBar(title: "Create New Exercise"),
      body: SingleChildScrollView(
        child: Container(
          height: size.width / 0.5,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width / 25,
                right: size.width / 25,
                top: size.width / 20),
            child: Column(
              children: [
                _nameExercise(title: "Name Exercise"),
                SizedBox(
                  height: size.width / 20,
                ),
                _descriptionExercise(title: "Description"),
                SizedBox(
                  height: size.width / 20,
                ),
                _dropNameCourse(context),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      print("aha $dropdownValue");
                    });
                    print("hihi $dropdownValue");
                  },
                  items: <String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocProvider<GetCourseBloc> _dropNameCourse(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetCourseBloc>(),
      child: Builder(builder: (context) {
        return BodyGetCourse(
          changeWithPage: "CreateExercisePage",
        );
      }),
    );
  }

  Widget _descriptionExercise({String? title}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 1.7,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width / 20,
                fontWeight: FontWeight.w600),
          ),
          Container(
            height: size.width / 2,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(size.width / 30),
                ),
                border: Border.all(color: Colors.grey, width: 2.0)),
            child: Padding(
              padding: EdgeInsets.all(size.width / 20),
              child: Container(
                height: size.width / 3.2,
                child: ListView(
                  children: [
                    // Text(
                    //   content!,
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: size.width / 25,
                    //       fontWeight: FontWeight.w300),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameExercise({String? title}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 4.7,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: size.width / 20),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Input name",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width / 30),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width / 30),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
            ),
            onTap: () {
              setState(() {});
            },
            controller: _controller,
          ),
        ],
      ),
    );
  }

  AppBar _appBar({String? title}) {
    Size size = MediaQuery.of(context).size;

    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: Text(
        title!,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: size.width / 20),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
