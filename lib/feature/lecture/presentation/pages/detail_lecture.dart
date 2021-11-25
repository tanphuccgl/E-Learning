import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_all_lecture_of_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/manager/get_info_lecture/get_info_lecture_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/widgets/body_detail_lecture.dart';

class DetailLecturePage extends StatefulWidget {
  final int? idLecture;
  static const String routeName = "/DetailLecturePage";

  const DetailLecturePage({Key? key, this.idLecture}) : super(key: key);

  @override
  _DetailLecturePageState createState() => _DetailLecturePageState();
}

class _DetailLecturePageState extends State<DetailLecturePage> {


  @override
  Widget build(BuildContext context) {

    return
      BlocProvider(
        create: (_) => sl<GetInfoLectureBloc>(),
        child: BodyDetailLecture(idLecture: widget.idLecture,

        ),
      );
  }


}
