import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/data/models/list_teacher_response_model.dart';

@immutable
abstract class ListTeacherState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends ListTeacherState {}

class Loading extends ListTeacherState {}

class Loaded extends ListTeacherState {
  final ListTeacherResponseModel? swagger;
  final List<Data>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends ListTeacherState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
