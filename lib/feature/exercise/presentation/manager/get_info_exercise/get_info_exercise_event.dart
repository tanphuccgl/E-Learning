import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetInfoExerciseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetInfoExerciseEventE extends GetInfoExerciseEvent {
  final int? idExercise;

  GetInfoExerciseEventE({this.idExercise});
}
