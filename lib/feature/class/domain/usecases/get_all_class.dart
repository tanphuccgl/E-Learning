import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/models/get_all_class_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/domain/repositories/get_all_class_repository.dart';

class GetAllClass implements UseCase<GetAllClassResponseModel, NoParams> {
  final GetAllClassRepository? getAllClassRepository;

  GetAllClass(this.getAllClassRepository);

  @override
  Future<Either<Failure, GetAllClassResponseModel>> call(
      NoParams params) async {
    return await getAllClassRepository!.getAllClass();
  }
}
