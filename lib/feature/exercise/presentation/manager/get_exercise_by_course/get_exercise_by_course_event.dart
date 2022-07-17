import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetExerciseByCourseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExerciseByCourseEventE extends GetExerciseByCourseEvent {
  final String? idCourse;

  GetExerciseByCourseEventE({this.idCourse});
}
