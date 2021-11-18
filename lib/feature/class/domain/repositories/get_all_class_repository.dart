import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/models/get_all_class_response_model.dart';

abstract class GetAllClassRepository {
  Future<Either<Failure, GetAllClassResponseModel>> getAllClass();
}
