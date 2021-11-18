import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';

@immutable
abstract class GetMemberInCourseState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetMemberInCourseState {}

class Loading extends GetMemberInCourseState {}

class Loaded extends GetMemberInCourseState {
  final GetMemberInCourseResponse? swagger;
  final List<GetMemberInCourseData>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetMemberInCourseState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
