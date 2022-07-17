import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_point_student_res.dart';

abstract class GetPointStudentRepository {
  Future<Either<Failure, GetPointStudentResponse>> getPointStudent(
      String idCourse, int idAccount);
}
