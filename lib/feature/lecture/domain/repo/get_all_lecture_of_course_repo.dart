import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_all_lecture_of_course_res.dart';

abstract class GetAllLectureRepository {
  Future<Either<Failure, GetAllLectureResponse>> getAllLecture(String idCourse);
}
