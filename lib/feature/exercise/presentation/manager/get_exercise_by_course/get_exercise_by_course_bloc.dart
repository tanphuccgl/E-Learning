import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/usecase/get_exercise_by_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_state.dart';


class GetExerciseByCourseBloc extends Bloc<GetExerciseByCourseEvent, GetExerciseByCourseState> {
  final GetExerciseByCourse getExerciseByCourse;


  GetExerciseByCourseBloc({@required GetExerciseByCourse? pr})
      : assert(pr != null),
        getExerciseByCourse = pr!,
        super(Empty());

  @override
  GetExerciseByCourseState get initialState => Empty();

  @override
  Stream<GetExerciseByCourseState> mapEventToState(GetExerciseByCourseEvent event) async* {
    if (event is GetExerciseByCourseEventE) {
      yield Loading();
      final failureOrSuccess = await getExerciseByCourse(
          GetExerciseByCourseParams(idCourse : event.idCourse ));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetExerciseByCourseState> _eitherLoadedOrErrorState(
      Either<Failure, GetExerciseByCourseResponse> failureOrSuccess) async* {
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
