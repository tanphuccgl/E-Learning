import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_info_lecture_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/domain/usercase/get_info_lecture.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/manager/get_info_lecture/get_info_lecture_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/manager/get_info_lecture/get_info_lecture_state.dart';

class GetInfoLectureBloc
    extends Bloc<GetInfoLectureEvent, GetInfoLectureState> {
  final GetInfoLecture getInfoLecture;

  // final GetLocalProfile getLocalProfile;

  GetInfoLectureBloc({@required GetInfoLecture? pr})
      : assert(pr != null),
        getInfoLecture = pr!,
        super(Empty());

  @override
  GetInfoLectureState get initialState => Empty();

  @override
  Stream<GetInfoLectureState> mapEventToState(
      GetInfoLectureEvent event) async* {
    if (event is GetInfoLectureEventE) {
      yield Loading();
      final failureOrSuccess = await getInfoLecture(
          GetInfoLectureParams(idLecture: event.idLecture));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetInfoLectureState> _eitherLoadedOrErrorState(
      Either<Failure, GetInfoLectureResponse> failureOrSuccess) async* {
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
