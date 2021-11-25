import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_point_teacher_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/usecases/get_point_teacher.dart';


import 'get_point_teacher_event.dart';
import 'get_point_teacher_state.dart';


class GetPointTeacherBloc extends Bloc<GetPointTeacherEvent, GetPointTeacherState> {
  final GetPointTeacher getPointTeacher;

  // final GetLocalProfile getLocalProfile;

  GetPointTeacherBloc({@required GetPointTeacher? pr})
      : assert(pr != null),
        getPointTeacher = pr!,
        super(Empty());

  @override
  GetPointTeacherState get initialState => Empty();

  @override
  Stream<GetPointTeacherState> mapEventToState(GetPointTeacherEvent event) async* {
    if (event is GetPointTeacherEventE) {
      yield Loading();
      final failureOrSuccess = await getPointTeacher(
          GetPointTeacherParams(idCourse : event.idCourse ));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetPointTeacherState> _eitherLoadedOrErrorState(
      Either<Failure, GetPointTeacherResponse> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (res) => Loaded(swagger: res,data2: res.data),
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
