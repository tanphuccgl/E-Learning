import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';

@immutable
abstract class GetInfoExerciseState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetInfoExerciseState {}

class Loading extends GetInfoExerciseState {}

class Loaded extends GetInfoExerciseState {
  final GetInfoExerciseResponse? swagger;
  final GetInfoExerciseData? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetInfoExerciseState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
