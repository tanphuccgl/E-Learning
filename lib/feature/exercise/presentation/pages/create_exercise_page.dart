import 'package:flutter/material.dart';

class CreateExercisePage extends StatefulWidget {
  static const String routeName = "/CreateExercisePage";

  const CreateExercisePage({Key? key}) : super(key: key);

  @override
  _CreateExercisePageState createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: _appBar(title: "Create New Exercise"),
      body: Container(
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
            ],
          ),
        ),
      ),
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
          TextFormField(
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
