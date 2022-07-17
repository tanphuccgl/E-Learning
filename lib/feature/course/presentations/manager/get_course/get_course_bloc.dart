import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/usecases/get_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_state.dart';

class GetCourseBloc extends Bloc<GetCourseEvent, GetCourseState> {
  final GetCourse getCourse;

  // final GetLocalProfile getLocalProfile;

  GetCourseBloc({@required GetCourse? pr})
      : assert(pr != null),
        getCourse = pr!,
        super(Empty());

  @override
  GetCourseState get initialState => Empty();

  @override
  Stream<GetCourseState> mapEventToState(GetCourseEvent event) async* {
    if (event is GetCourseEventE) {
      yield Loading();
      final failureOrSuccess = await getCourse(GetCourseParams(
          keySearchNameCourse: event.keySearchNameCourse,
          idAccount: event.idAccount));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetCourseState> _eitherLoadedOrErrorState(
      Either<Failure, GetCourseResponse> failureOrSuccess) async* {
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
