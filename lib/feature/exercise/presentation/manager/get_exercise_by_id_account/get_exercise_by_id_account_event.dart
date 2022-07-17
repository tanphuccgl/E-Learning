import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetExerciseByIdAccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExerciseByIdAccountEventE extends GetExerciseByIdAccountEvent {
  final int? idAccount;

  GetExerciseByIdAccountEventE({this.idAccount});
}
