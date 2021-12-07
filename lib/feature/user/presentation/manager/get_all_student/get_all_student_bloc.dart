import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_studen_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/domain/usecase/get_all_student.dart';

import 'get_all_student_event.dart';
import 'get_all_student_state.dart';



class GetAllStudentBloc extends Bloc<GetAllStudentEvent, GetAllStudentState> {
  final GetAllStudent? getGetAllStudent;

  GetAllStudentBloc({@required GetAllStudent? pr})
      : assert(pr != null),
        getGetAllStudent = pr,
        super(Empty1());

  GetAllStudentState get initialState => Empty1();

  @override
  Stream<GetAllStudentState> mapEventToState(GetAllStudentEvent event) async* {
    if (event is GetAllStudentE) {
      yield Loading1();
      final failureOrSuccess = await getGetAllStudent!(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetAllStudentState> _eitherLoadedOrErrorState(
      Either<Failure, GetAllStudentResponse> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
          (failure) => Error1(message: _mapFailureToMessage(failure)),
          (res) => Loaded1(swagger: res, data: res.data),
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
