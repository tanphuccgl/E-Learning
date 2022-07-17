import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetPointTeacherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPointTeacherEventE extends GetPointTeacherEvent {
  final String? idCourse;

  GetPointTeacherEventE({
    this.idCourse,
  });
}
