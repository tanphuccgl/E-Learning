import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/network/network_info.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/data_sources/get_course_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/repositories/get_course_repo.dart';


class GetCourseRepositoryImpl extends GetCourseRepository {
  final NetworkInfo? networkInfo;
  final GetCourseRemoteDataSource? getCourseRemoteDataSource;

  GetCourseRepositoryImpl({
    this.networkInfo,
    this.getCourseRemoteDataSource,
  });

  @override
  Future<Either<Failure, GetCourseResponse>> getCourse(
      String keySearchNameCourse
      , String idAccount) {
    return _courseContents(
        getCourseRemoteDataSource!.getCourse(keySearchNameCourse, idAccount));
  }

  Future<Either<Failure, GetCourseResponse>> _courseContents(
      Future<GetCourseResponse> getCourse) async {
    if (await networkInfo!.isConnected) {
      try {
        final course = await getCourse;
        return Right(course);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
