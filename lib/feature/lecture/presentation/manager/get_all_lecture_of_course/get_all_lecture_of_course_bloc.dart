import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_all_lecture_of_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/domain/usercase/get_all_lecture_of_course.dart';

import 'get_all_lecture_of_course_event.dart';
import 'get_all_lecture_of_course_state.dart';

class GetAllLectureBloc extends Bloc<GetAllLectureEvent, GetAllLectureState> {
  final GetAllLecture getAllLecture;

  // final GetLocalProfile getLocalProfile;

  GetAllLectureBloc({@required GetAllLecture? pr})
      : assert(pr != null),
        getAllLecture = pr!,
        super(Empty());

  @override
  GetAllLectureState get initialState => Empty();

  @override
  Stream<GetAllLectureState> mapEventToState(GetAllLectureEvent event) async* {
    if (event is GetAllLectureEventE) {
      yield Loading();
      final failureOrSuccess =
          await getAllLecture(GetAllLectureParams(idCourse: event.idCourse));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetAllLectureState> _eitherLoadedOrErrorState(
      Either<Failure, GetAllLectureResponse> failureOrSuccess) async* {
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
