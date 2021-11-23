import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_id_account_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_grade_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/repositories/get_exercise_by_id_account_repo.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/repositories/get_grade_exercise_repo.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/repositories/get_info_exercise_repo.dart';

class GetGradeExercise
    implements UseCase<GetGradeExerciseResponse, GetGradeExerciseParams> {
  final GetGradeExerciseRepository getGradeExerciseRepository;

  GetGradeExercise(this.getGradeExerciseRepository);

  @override
  Future<Either<Failure, GetGradeExerciseResponse>> call(
      GetGradeExerciseParams params) async {
    return await getGradeExerciseRepository.getGradeExercise(
        params.idExercise!, params.idCourse!);
  }
}

class GetGradeExerciseParams extends Equatable {
  final int? idExercise;

  final String? idCourse;

  GetGradeExerciseParams({this.idExercise, this.idCourse});

  @override
  // TODO: implement props
  List<Object> get props => [idExercise!];
}
