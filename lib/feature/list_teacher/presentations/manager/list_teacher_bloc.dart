import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/data/models/list_teacher_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/domain/usecases/get_list_teacher.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/presentations/manager/list_teacher_event.dart';

import 'list_teacher_state.dart';

class ListTeacherBloc extends Bloc<ListTeacherEvent, ListTeacherState> {
  final GetListTeacher? getListTeacher;

  ListTeacherBloc({@required GetListTeacher? pr})
      : assert(pr != null),
        getListTeacher = pr,
        super(Empty());

  ListTeacherState get initialState => Empty();

  @override
  Stream<ListTeacherState> mapEventToState(ListTeacherEvent event) async* {
    if (event is GetListTeacherE) {
      yield Loading();
      final failureOrSuccess = await getListTeacher!(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<ListTeacherState> _eitherLoadedOrErrorState(
      Either<Failure, ListTeacherResponseModel> failureOrSuccess) async* {
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
