import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_all_lecture_of_course_res.dart';

@immutable
abstract class GetAllLectureState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetAllLectureState {}

class Loading extends GetAllLectureState {}

class Loaded extends GetAllLectureState {
  final GetAllLectureResponse? swagger;
  final List<GetAllLectureData>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetAllLectureState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
