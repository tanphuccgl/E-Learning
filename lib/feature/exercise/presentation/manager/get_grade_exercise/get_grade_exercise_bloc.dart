import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_grade_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/usecase/get_grade_exercise.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_grade_exercise/get_grade_exercise_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_grade_exercise/get_grade_exercise_state.dart';

class GetGradeExerciseBloc
    extends Bloc<GetGradeExerciseEvent, GetGradeExerciseState> {
  final GetGradeExercise getGradeExercise;

  GetGradeExerciseBloc({@required GetGradeExercise? pr})
      : assert(pr != null),
        getGradeExercise = pr!,
        super(Empty());

  @override
  GetGradeExerciseState get initialState => Empty();

  @override
  Stream<GetGradeExerciseState> mapEventToState(
      GetGradeExerciseEvent event) async* {
    if (event is GetGradeExerciseEventE) {
      yield Loading();
      final failureOrSuccess = await getGradeExercise(GetGradeExerciseParams(
          idExercise: event.idExercise, idCourse: event.idCourse));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetGradeExerciseState> _eitherLoadedOrErrorState(
      Either<Failure, GetGradeExerciseResponse> failureOrSuccess) async* {
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
