import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/usecases/get_member_in_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_state.dart';



class GetMemberInCourseBloc extends Bloc<GetMemberInCourseEvent, GetMemberInCourseState> {
  final GetMemberInCourse getMemberInCourse;

  // final GetLocalProfile getLocalProfile;

  GetMemberInCourseBloc({@required GetMemberInCourse? pr})
      : assert(pr != null),
        getMemberInCourse = pr!,
        super(Empty());

  @override
  GetMemberInCourseState get initialState => Empty();

  @override
  Stream<GetMemberInCourseState> mapEventToState(GetMemberInCourseEvent event) async* {
    if (event is GetMemberInCourseEventE) {
      yield Loading();
      final failureOrSuccess = await getMemberInCourse(
          GetMemberInCourseParams(idCourse : event.idCourse , keySearchName:  event.keySearchName));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<GetMemberInCourseState> _eitherLoadedOrErrorState(
      Either<Failure, GetMemberInCourseResponse> failureOrSuccess) async* {
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
