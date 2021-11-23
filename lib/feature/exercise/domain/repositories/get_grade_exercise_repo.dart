import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_grade_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';


abstract class GetGradeExerciseRepository {
  Future<Either<Failure, GetGradeExerciseResponse>> getGradeExercise(
      int idExercise,String idCourse
      );
}
