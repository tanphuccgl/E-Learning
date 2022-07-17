import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetInfoLectureEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetInfoLectureEventE extends GetInfoLectureEvent {
  final int? idLecture;

  GetInfoLectureEventE({this.idLecture});
}
