import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_info_exercise/get_info_exercise_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/execise_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/body_detail_exercise.dart';

class DetailExercisePage extends StatefulWidget {
  final int? idExercise;
  final String? descriptionExercise;
  final String? allowSubmission;
  final String? submissionDeadline;
  final String? nameExercise;
  static const String routeName = "/DetailExercisePage";

  const DetailExercisePage(
      {Key? key,
      this.idExercise,
      this.submissionDeadline,
      this.nameExercise,
      this.allowSubmission,
      this.descriptionExercise})
      : super(key: key);

  @override
  _DetailExercisePageState createState() => _DetailExercisePageState();
}

class _DetailExercisePageState extends State<DetailExercisePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetInfoExerciseBloc>(),
      child: BodyDetailExercise(
        idExercise: widget.idExercise,
        descriptionExercise: widget.descriptionExercise,
        allowSubmission: widget.allowSubmission,
        submissionDeadline: widget.submissionDeadline,
          nameExercise:widget.nameExercise
      ),
    );
  }
}
