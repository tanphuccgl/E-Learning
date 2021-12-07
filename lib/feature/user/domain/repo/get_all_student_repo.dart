import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_studen_res.dart';

abstract class GetAllStudentRepository {
  Future<Either<Failure, GetAllStudentResponse>> getAllStudent();
}
