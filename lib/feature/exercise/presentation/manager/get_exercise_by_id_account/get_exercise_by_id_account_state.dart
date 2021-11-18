import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_id_account_res.dart';

@immutable
abstract class GetExerciseByIdAccountState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetExerciseByIdAccountState {}

class Loading extends GetExerciseByIdAccountState {}

class Loaded extends GetExerciseByIdAccountState {
  final GetExerciseByIdAccountResponse? swagger;
  final List<GetExerciseByIdAccountData>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetExerciseByIdAccountState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
