import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/models/login_data.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/domain/usecases/get_current_user.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/domain/usecases/post_login.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/presentations/manager/login_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/presentations/manager/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostLogin postLogin;
  final GetCurrentUser getCurrentUser;

  LoginBloc({PostLogin? lg, GetCurrentUser? cu})
      : assert(lg != null),
        assert(cu != null),
        getCurrentUser = cu!,
        postLogin = lg!,
        super(Empty());

  LoginState get initialState => Empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is IsLogin) {
      yield Loading();
      final result = await getCurrentUser(NoParams());
      yield* _eitherLoginOrErrorState(result);
    }
    if (event is LoginE) {
      yield Loading();
      final result =
          await postLogin(LoginParams(email: event.email, pass: event.pass));
      yield* _eitherLoadedOrErrorState(result);
    }
    if (event is ClearE) {
      yield Empty();
    }
  }

  Stream<LoginState> _eitherLoadedOrErrorState(
      Either<Failure, LoginData> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (res) => Loaded(data: res),
    );
  }

  Stream<LoginState> _eitherLoginOrErrorState(
      Either<Failure, LoginData> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
      (failure) => NotLogin(),
      (res) => LoginAlready(),
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
