import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/widgets/body_grading_assignment.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_grade_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';

class GradingAssignmentPage extends StatefulWidget {
  final int? isTextPoint;
  final int? idAccount;
  final int? idAnswer;
  final GetGradeExerciseData? data;
  final String? nameStudent;
  final String? createDate;

  static const String routeName = "/GradingAssignmentPage";

  const GradingAssignmentPage(
      {Key? key,
      this.createDate,
      this.isTextPoint,
      this.data,
      this.idAccount,
      this.idAnswer,
      this.nameStudent})
      : super(key: key);

  @override
  _GradingAssignmentPageState createState() => _GradingAssignmentPageState();
}

class _GradingAssignmentPageState extends State<GradingAssignmentPage> {
  bool _showBackToTopButton = false;

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController!.offset > 10) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    _scrollController!.dispose(); // dispose the controller
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController!.animateTo(0,
        duration: Duration(milliseconds: 250), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context: context, title: "Grading Assignment"),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              child: Icon(Icons.arrow_upward),
            ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: BlocProvider(
            create: (_) => sl<GetInformationAnswerBloc>(),
            child: BodyGradingAssignment(
                idAccount: widget.idAccount,
                idAnswer: widget.idAnswer,
                nameStudent: widget.nameStudent,
                createDate: widget.createDate)),
      ),
    );
  }
}
