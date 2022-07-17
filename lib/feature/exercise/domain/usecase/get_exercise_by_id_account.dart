import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_id_account_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/repositories/get_exercise_by_id_account_repo.dart';

class GetExerciseByIdAccount
    implements
        UseCase<GetExerciseByIdAccountResponse, GetExerciseByIdAccountParams> {
  final GetExerciseByIdAccountRepository exerciseByIdAccountRepository;

  GetExerciseByIdAccount(this.exerciseByIdAccountRepository);

  @override
  Future<Either<Failure, GetExerciseByIdAccountResponse>> call(
      GetExerciseByIdAccountParams params) async {
    return await exerciseByIdAccountRepository.getExerciseByIdAccount(
      params.idAccount!,
    );
  }
}

class GetExerciseByIdAccountParams extends Equatable {
  final int? idAccount;

  GetExerciseByIdAccountParams({
    this.idAccount,
  });

  @override
  // TODO: implement props
  List<Object> get props => [idAccount!];
}
