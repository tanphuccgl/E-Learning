import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_studen_res.dart';

@immutable
abstract class GetAllStudentState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty1 extends GetAllStudentState {}

class Loading1 extends GetAllStudentState {}

class Loaded1 extends GetAllStudentState {
  final GetAllStudentResponse? swagger;
  final List<GetAllStudentData>? data;

  Loaded1({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error1 extends GetAllStudentState {
  final String? message;

  Error1({@required this.message});

  @override
  List<Object> get props => [message!];
}
