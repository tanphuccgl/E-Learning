import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_point_teacher_res.dart';

@immutable
abstract class GetPointTeacherState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetPointTeacherState {}

class Loading extends GetPointTeacherState {}

class Loaded extends GetPointTeacherState {
  final GetPointTeacherResponse? swagger;
  // final List<GetPointTeacherData>? data1;
  final List<Data>? data2;


  Loaded({@required this.swagger,@required this.data2});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetPointTeacherState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
