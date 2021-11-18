import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/models/login_data.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/domain/repositories/login_repository.dart';

class GetCurrentUser implements UseCase<LoginData, NoParams> {
  final LoginRepository? loginRepository;

  GetCurrentUser({@required this.loginRepository});
  @override
  Future<Either<Failure, LoginData>> call(NoParams params) async {
    return await loginRepository!.getCurrentUser();
  }
}
