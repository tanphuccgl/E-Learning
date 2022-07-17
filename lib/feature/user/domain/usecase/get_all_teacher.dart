import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/models/get_all_class_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/domain/repositories/get_all_class_repository.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_teacher_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/domain/repo/get_all_teacher_repo.dart';

class GetAllTeacher implements UseCase<GetAllTeacherResponse, NoParams> {
  final GetAllTeacherRepository? getAllTeacherRepository;

  GetAllTeacher(this.getAllTeacherRepository);

  @override
  Future<Either<Failure, GetAllTeacherResponse>> call(NoParams params) async {
    return await getAllTeacherRepository!.getAllTeacher();
  }
}
