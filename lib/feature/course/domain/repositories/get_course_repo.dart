import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';


abstract class GetCourseRepository {
  Future<Either<Failure, GetCourseResponse>> getCourse(
      String keySearchNameCourse
      , String idAccount);
}
