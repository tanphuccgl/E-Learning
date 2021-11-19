import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/execise_page.dart';

class DetailExercisePage extends StatefulWidget {
  final GetExerciseByCourseData? data;
  static const String routeName = "/DetailExercisePage";

  const DetailExercisePage({Key? key, this.data}) : super(key: key);

  @override
  _DetailExercisePageState createState() => _DetailExercisePageState();
}

class _DetailExercisePageState extends State<DetailExercisePage> {
  String a = "TTO - Trên giao diện của Tuổi Trẻ Online hôm nay, bạ"
      "n đọc có thể click (bấm chuột) vào một chỉ dấu để sẵn trên "
      "màn hình, để gửi những tiếng chuông   23 31tưởng"
      " nhớ đồng bào đã mất vì đại dịch fdsfdCOVID-19."
      " nhớ đồng bào đã mất vì đại dịch COfasdfdVID-19."
      "n đọc có thể click (bấm chuột) vào một chỉ dấu để sẵn trên "
      "màn hình, để gửi những tiếng chuông   23 31tưởng"
      " nhớ đồng bào đã mất vì đại dịch fdsfdCOVID-19."
      " nhớ đồng bào đã mất vì đại dịch COfasdfdVID-19."
      " nhớ đồng bào đã mất vì đại dịch COVID-19.";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(title: widget.data!.titleExercise),
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width / 25,
              right: size.width / 25,
              top: size.width / 20),
          child: Column(
            children: [
              _header(
                  allowSubmission: widget.data?.allowSubmission,
                  submissionDeadline: widget.data?.submissionDeadline),
              _content(content: a),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content({String? content}) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding:  EdgeInsets.only(top: size.width/15),
      child: Container(
        height: size.width / 2,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(size.width / 30),
            ),
            color: Colors.grey.shade300.withOpacity(0.3),
            border: Border.all(
                color: Colors.cyan.withOpacity(0.3), width: size.width / 100)),
        child: Padding(
          padding: EdgeInsets.all(size.width / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width / 20,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                height: size.width / 3.2,
                child: ListView(
                  children: [
                    Text(
                      content!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width / 25,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _header({String? submissionDeadline, String? allowSubmission}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 5,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(size.width / 30),
        ),
        color: Colors.cyan.withOpacity(0.3),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Allow Submission: ${parseStringToTime(textTime: allowSubmission)}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 25,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Submission Deadline: ${parseStringToTime(textTime: submissionDeadline)}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 25,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  PreferredSize _appBar({String? title}) {
    Size size = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size.fromHeight(size.width / 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          title!,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.width / 15),
        ),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
