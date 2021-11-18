import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/network/network_info.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/data_source/get_exercise_by_id_account_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_id_account_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/repositories/get_exercise_by_id_account_repo.dart';




class GetExerciseByIdAccountRepositoryImpl extends GetExerciseByIdAccountRepository {
  final NetworkInfo? networkInfo;
  final GetExerciseByIdAccountRemoteDataSource? getExerciseByIdAccountRemoteDataSource;

  GetExerciseByIdAccountRepositoryImpl({
    this.networkInfo,
    this.getExerciseByIdAccountRemoteDataSource,
  });

  @override
  Future<Either<Failure, GetExerciseByIdAccountResponse>> getExerciseByIdAccount(
      int idAccount
      ) {
    return _exerciseByIdAccountContents(
        getExerciseByIdAccountRemoteDataSource!.getExerciseByIdAccount(idAccount  ));
  }

  Future<Either<Failure, GetExerciseByIdAccountResponse>> _exerciseByIdAccountContents(
      Future<GetExerciseByIdAccountResponse> getExerciseByIdAccount) async {
    if (await networkInfo!.isConnected) {
      try {
        final exerciseByIdAccount = await getExerciseByIdAccount;
        return Right(exerciseByIdAccount);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
