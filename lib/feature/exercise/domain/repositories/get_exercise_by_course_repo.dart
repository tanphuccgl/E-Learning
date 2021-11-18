import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_course_res.dart';


abstract class GetExerciseByCourseRepository {
  Future<Either<Failure, GetExerciseByCourseResponse>> getExerciseByCourse(
      String idCourse
    );
}
