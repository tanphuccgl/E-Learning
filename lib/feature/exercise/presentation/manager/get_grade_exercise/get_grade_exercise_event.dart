import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetGradeExerciseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetGradeExerciseEventE extends GetGradeExerciseEvent {
  final int? idExercise;
  final String? idCourse;

  GetGradeExerciseEventE({this.idExercise, this.idCourse});
}
