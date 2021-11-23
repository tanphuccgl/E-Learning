import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/data/models/get_dashboard_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/domain/usecase/get_dashboard.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/manager/get_dashboard/get_dashboard_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/manager/get_dashboard/get_dashboard_state.dart';




class GetDashboardBloc extends Bloc<GetDashboardEvent, GetDashboardState> {
  final GetDashboard? getGetDashboard;

  GetDashboardBloc({@required GetDashboard? pr})
      : assert(pr != null),
        getGetDashboard = pr,
        super(Empty());

  GetDashboardState get initialState => Empty();

  @override
  Stream<GetDashboardState> mapEventToState(GetDashboardEvent event) async* {
    if (event is GetGetDashboardE) {
      yield Loading();
      final failureOrSuccess = await getGetDashboard!(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetDashboardState> _eitherLoadedOrErrorState(
      Either<Failure, GetDashboardResponse> failureOrSuccess) async* {
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
