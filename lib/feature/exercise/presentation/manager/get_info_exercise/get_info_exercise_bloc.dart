import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/usecase/get_info_exercise.dart';

import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_info_exercise/get_info_exercise_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_info_exercise/get_info_exercise_state.dart';

class GetInfoExerciseBloc
    extends Bloc<GetInfoExerciseEvent, GetInfoExerciseState> {
  final GetInfoExercise getInfoExercise;

  GetInfoExerciseBloc({@required GetInfoExercise? pr})
      : assert(pr != null),
        getInfoExercise = pr!,
        super(Empty());

  @override
  GetInfoExerciseState get initialState => Empty();

  @override
  Stream<GetInfoExerciseState> mapEventToState(
      GetInfoExerciseEvent event) async* {
    if (event is GetInfoExerciseEventE) {
      yield Loading();
      final failureOrSuccess = await getInfoExercise(
          GetInfoExerciseParams(idExercise: event.idExercise));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetInfoExerciseState> _eitherLoadedOrErrorState(
      Either<Failure, GetInfoExerciseResponse> failureOrSuccess) async* {
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
