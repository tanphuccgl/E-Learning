import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/data/models/list_teacher_response_model.dart';

abstract class ListTeacherRepository {
  Future<Either<Failure, ListTeacherResponseModel>> getListTeacher();
}
