import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';

@immutable
abstract class GetCourseState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetCourseState {}

class Loading extends GetCourseState {}

class Loaded extends GetCourseState {
  final GetCourseResponse? swagger;
  final List<GetCourseData>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetCourseState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
