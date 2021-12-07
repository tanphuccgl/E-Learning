import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/network/network_info.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/data_source/get_all_student_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_studen_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/domain/repo/get_all_student_repo.dart';

class GetAllStudentRepositoryImpl extends GetAllStudentRepository {
  final NetworkInfo? networkInfo;
  final GetAllStudentRemoteDataSource? getAllStudentRemoteDataSource;

  GetAllStudentRepositoryImpl({
    this.networkInfo,
    this.getAllStudentRemoteDataSource,
  });

  @override
  Future<Either<Failure, GetAllStudentResponse>> getAllStudent() {
    return _getAllStudent(getAllStudentRemoteDataSource!.getAllStudent());
  }

  Future<Either<Failure, GetAllStudentResponse>> _getAllStudent(
      Future<GetAllStudentResponse> getProduct) async {
    if (await networkInfo!.isConnected) {
      try {
        final product = await getProduct;
        return Right(product);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
