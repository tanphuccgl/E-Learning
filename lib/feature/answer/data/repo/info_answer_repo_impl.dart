import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/network/network_info.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/data_course/get_info_answer_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/models/get_info_answer_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/domain/repo/info_answer_repo.dart';

class GetInformationAnswerRepositoryImpl
    extends GetInformationAnswerRepository {
  final NetworkInfo? networkInfo;
  final GetInformationAnswerRemoteDataSource?
      getInformationAnswerRemoteDataSource;

  GetInformationAnswerRepositoryImpl({
    this.networkInfo,
    this.getInformationAnswerRemoteDataSource,
  });

  @override
  Future<Either<Failure, GetInformationAnswerResponse>> getInformationAnswer(
      int idAccount, int idAnswer) {
    return _infoAnswer(getInformationAnswerRemoteDataSource!
        .getInformationAnswer(idAccount, idAnswer));
  }

  Future<Either<Failure, GetInformationAnswerResponse>> _infoAnswer(
      Future<GetInformationAnswerResponse> getInformationAnswer) async {
    if (await networkInfo!.isConnected) {
      try {
        final info = await getInformationAnswer;
        return Right(info);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
