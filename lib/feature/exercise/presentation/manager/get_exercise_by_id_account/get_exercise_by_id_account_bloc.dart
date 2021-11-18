import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_id_account_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/usecase/get_exercise_by_id_account.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_id_account/get_exercise_by_id_account_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_id_account/get_exercise_by_id_account_state.dart';


class GetExerciseByIdAccountBloc extends Bloc<GetExerciseByIdAccountEvent, GetExerciseByIdAccountState> {
  final GetExerciseByIdAccount getExerciseByIdAccount;


  GetExerciseByIdAccountBloc({@required GetExerciseByIdAccount? pr})
      : assert(pr != null),
        getExerciseByIdAccount = pr!,
        super(Empty());

  @override
  GetExerciseByIdAccountState get initialState => Empty();

  @override
  Stream<GetExerciseByIdAccountState> mapEventToState(GetExerciseByIdAccountEvent event) async* {
    if (event is GetExerciseByIdAccountEventE) {
      yield Loading();
      final failureOrSuccess = await getExerciseByIdAccount(
          GetExerciseByIdAccountParams(idAccount  : event.idAccount  ));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetExerciseByIdAccountState> _eitherLoadedOrErrorState(
      Either<Failure, GetExerciseByIdAccountResponse> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (res) => Loaded(swagger: res, data: res.data),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
