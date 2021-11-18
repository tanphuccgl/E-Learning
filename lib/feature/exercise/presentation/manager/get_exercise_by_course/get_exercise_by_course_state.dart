import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_course_res.dart';

@immutable
abstract class GetExerciseByCourseState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetExerciseByCourseState {}

class Loading extends GetExerciseByCourseState {}

class Loaded extends GetExerciseByCourseState {
  final GetExerciseByCourseResponse? swagger;
  final List<GetExerciseByCourseData>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetExerciseByCourseState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
