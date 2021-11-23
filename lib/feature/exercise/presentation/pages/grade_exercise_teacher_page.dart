import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_grade_exercise/get_grade_exercise_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/body_grade_exer.dart';

class GradeExerciseTeacherPage extends StatefulWidget {
  final int? idExercise;
  final String? idCourse;
  final int? isTextPoint;
  static const String routeName="/GradeExerciseTeacherPage";
  const GradeExerciseTeacherPage({Key? key,this.idCourse,this.idExercise,this.isTextPoint}) : super(key: key);

  @override
  _GradeExerciseTeacherPageState createState() => _GradeExerciseTeacherPageState();
}

class _GradeExerciseTeacherPageState extends State<GradeExerciseTeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "List submitting assignments"),
      body: BlocProvider(
        create: (_) => sl<GetGradeExerciseBloc>(),
        child: BodyGradeExe(idExercise: widget.idExercise,idCourse: widget.idCourse,isTextPoint: widget.isTextPoint,

        ),
      ),
    );
  }

}
