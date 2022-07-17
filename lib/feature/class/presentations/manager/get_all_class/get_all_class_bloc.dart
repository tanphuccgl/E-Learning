import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/models/get_all_class_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/domain/usecases/get_all_class.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_state.dart';

class GetAllClassBloc extends Bloc<GetAllClassEvent, GetAllClassState> {
  final GetAllClass? getGetAllClass;

  GetAllClassBloc({@required GetAllClass? pr})
      : assert(pr != null),
        getGetAllClass = pr,
        super(Empty());

  GetAllClassState get initialState => Empty();

  @override
  Stream<GetAllClassState> mapEventToState(GetAllClassEvent event) async* {
    if (event is GetGetAllClassE) {
      yield Loading();
      final failureOrSuccess = await getGetAllClass!(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetAllClassState> _eitherLoadedOrErrorState(
      Either<Failure, GetAllClassResponseModel> failureOrSuccess) async* {
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
