import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';


abstract class GetMemberInCourseRepository {
  Future<Either<Failure, GetMemberInCourseResponse>> getMemberInCourse(
      String idCourse
      , String keySearchName);
}
