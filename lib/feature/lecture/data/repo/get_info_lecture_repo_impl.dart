import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/network/network_info.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/data_source/get_info_lecture_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_info_lecture_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/domain/repo/get_info_lecture_repo.dart';



class GetInfoLectureRepositoryImpl extends GetInfoLectureRepository {
  final NetworkInfo? networkInfo;
  final GetInfoLectureRemoteDataSource? getInfoLectureRemoteDataSource;

  GetInfoLectureRepositoryImpl({
    this.networkInfo,
    this.getInfoLectureRemoteDataSource,
  });

  @override
  Future<Either<Failure, GetInfoLectureResponse>> getInfoLecture(
      int idLecture
      ) {
    return _lectureInCourseContents(
        getInfoLectureRemoteDataSource!.getInfoLecture(idLecture  ));
  }

  Future<Either<Failure, GetInfoLectureResponse>> _lectureInCourseContents(
      Future<GetInfoLectureResponse> getInfoLecture) async {
    if (await networkInfo!.isConnected) {
      try {
        final lecture = await getInfoLecture;
        return Right(lecture);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
