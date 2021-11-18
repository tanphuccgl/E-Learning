import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_id_account_res.dart';


abstract class GetExerciseByIdAccountRepository {
  Future<Either<Failure, GetExerciseByIdAccountResponse>> getExerciseByIdAccount(
      int idAccount
      );
}
