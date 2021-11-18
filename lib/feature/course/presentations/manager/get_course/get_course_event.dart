import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetCourseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCourseEventE extends GetCourseEvent {
  final String? keySearchNameCourse;
  final String? idAccount;

  GetCourseEventE({this.keySearchNameCourse, this.idAccount});
}
