import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/models/get_all_class_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_teacher_res.dart';

abstract class GetAllTeacherRepository {
  Future<Either<Failure, GetAllTeacherResponse>> getAllTeacher();
}
