import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/widgets/submit_status.dart';

class InfoAnswerPage extends StatefulWidget {
  final int? idAccount;
  final int? idAnswer;
  final String? allowSubmission;
  final String? submissionDeadline;
  static const String routeName = "/InfoAnswerPage";

  const InfoAnswerPage(
      {Key? key,
      this.idAccount,
      this.idAnswer,
      this.submissionDeadline,
      this.allowSubmission})
      : super(key: key);

  @override
  _InfoAnswerPageState createState() => _InfoAnswerPageState();
}

class _InfoAnswerPageState extends State<InfoAnswerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetInformationAnswerBloc>(),
      child: widget.idAnswer == null
          ? submitStatus(
              data: null,
              title: "Submission status",
              context: context,
              submissionDeadline: widget.submissionDeadline)
          : BodyInfoAnswer(
              idAccount: widget.idAccount,
              idAnswer: widget.idAnswer,
              allowSubmission: widget.allowSubmission,
              submissionDeadline: widget.submissionDeadline,
            ),
    );
  }
}
