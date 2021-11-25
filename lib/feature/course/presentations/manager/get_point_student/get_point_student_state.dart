import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_point_student_res.dart';

@immutable
abstract class GetPointStudentState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetPointStudentState {}

class Loading extends GetPointStudentState {}

class Loaded extends GetPointStudentState {
  final GetPointStudentResponse? swagger;
  // final List<GetPointStudentData>? data1;
  final List<GetPointStudentData>? data;


  Loaded({@required this.swagger,@required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetPointStudentState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
