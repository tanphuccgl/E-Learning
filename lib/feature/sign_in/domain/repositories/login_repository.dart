import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/models/login_data.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginData>> postLogin(String email, String pass);
  Future<Either<Failure, LoginData>> getCurrentUser();
}
