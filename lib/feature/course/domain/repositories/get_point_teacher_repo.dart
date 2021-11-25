import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_point_teacher_res.dart';


abstract class GetPointTeacherRepository {
  Future<Either<Failure, GetPointTeacherResponse>> getPointTeacher(
      String idCourse
      ,);
}
