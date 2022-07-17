import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetMemberInCourseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMemberInCourseEventE extends GetMemberInCourseEvent {
  final String? idCourse;
  final String? keySearchName;

  GetMemberInCourseEventE({this.idCourse, this.keySearchName});
}
