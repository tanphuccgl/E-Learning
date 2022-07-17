import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/models/get_info_answer_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/domain/usecase/get_info_answer.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_state.dart';

class GetInformationAnswerBloc
    extends Bloc<GetInformationAnswerEvent, GetInformationAnswerState> {
  final GetInformationAnswer getInformationAnswer;

  // final GetLocalProfile getLocalProfile;

  GetInformationAnswerBloc({@required GetInformationAnswer? pr})
      : assert(pr != null),
        getInformationAnswer = pr!,
        super(Empty());

  GetInformationAnswerState get initialState => Empty();

  @override
  Stream<GetInformationAnswerState> mapEventToState(
      GetInformationAnswerEvent event) async* {
    if (event is GetInformationAnswerEventE) {
      yield Loading();
      final failureOrSuccess = await getInformationAnswer(
          GetInformationAnswerParams(
              idAnswer: event.idAnswer, idAccount: event.idAccount));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetInformationAnswerState> _eitherLoadedOrErrorState(
      Either<Failure, GetInformationAnswerResponse> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (res) => Loaded(
        swagger: res,
      ),
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
