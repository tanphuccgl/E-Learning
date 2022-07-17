import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetPointStudentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPointStudentEventE extends GetPointStudentEvent {
  final String? idCourse;
  final int? idAccount;

  GetPointStudentEventE({this.idCourse, this.idAccount});
}
