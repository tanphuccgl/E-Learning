import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetAllLectureEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllLectureEventE extends GetAllLectureEvent {
  final String? idCourse;

  GetAllLectureEventE({this.idCourse});
}
