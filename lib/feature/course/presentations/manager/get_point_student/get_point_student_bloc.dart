


import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_point_student_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/usecases/get_point_student.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_point_student/get_point_student_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_point_student/get_point_student_state.dart';

class GetPointStudentBloc extends Bloc<GetPointStudentEvent, GetPointStudentState> {
  final GetPointStudent getPointStudent;

  // final GetLocalProfile getLocalProfile;

  GetPointStudentBloc({@required GetPointStudent? pr})
      : assert(pr != null),
        getPointStudent = pr!,
        super(Empty());

  @override
  GetPointStudentState get initialState => Empty();

  @override
  Stream<GetPointStudentState> mapEventToState(GetPointStudentEvent event) async* {
    if (event is GetPointStudentEventE) {
      yield Loading();
      final failureOrSuccess = await getPointStudent(
          GetPointStudentParams(idCourse : event.idCourse,idAccount: event.idAccount ));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetPointStudentState> _eitherLoadedOrErrorState(
      Either<Failure, GetPointStudentResponse> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (res) => Loaded(swagger: res,data: res.data),
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
