import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';

abstract class GetInfoExerciseRepository {
  Future<Either<Failure, GetInfoExerciseResponse>> getInfoExercise(
      int idExercise);
}
