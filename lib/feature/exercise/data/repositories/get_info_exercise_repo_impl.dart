import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/network/network_info.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/data_source/get_info_exercise_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/repositories/get_info_exercise_repo.dart';





class GetInfoExerciseRepositoryImpl extends GetInfoExerciseRepository {
  final NetworkInfo? networkInfo;
  final GetInfoExerciseRemoteDataSource? getInfoExerciseRemoteDataSource;

  GetInfoExerciseRepositoryImpl({
    this.networkInfo,
    this.getInfoExerciseRemoteDataSource,
  });

  @override
  Future<Either<Failure, GetInfoExerciseResponse>> getInfoExercise(
      int idExercise
      ) {
    return _infoExerciseContents(
        getInfoExerciseRemoteDataSource!.getInfoExercise(idExercise   ));
  }

  Future<Either<Failure, GetInfoExerciseResponse>> _infoExerciseContents(
      Future<GetInfoExerciseResponse> getInfoExercise) async {
    if (await networkInfo!.isConnected) {
      try {
        final infoExercise = await getInfoExercise;
        return Right(infoExercise);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
