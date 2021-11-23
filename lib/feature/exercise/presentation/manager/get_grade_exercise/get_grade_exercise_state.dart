import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_grade_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';

@immutable
abstract class GetGradeExerciseState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetGradeExerciseState {}

class Loading extends GetGradeExerciseState {}

class Loaded extends GetGradeExerciseState {
  final GetGradeExerciseResponse? swagger;
  final List<GetGradeExerciseData>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetGradeExerciseState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
