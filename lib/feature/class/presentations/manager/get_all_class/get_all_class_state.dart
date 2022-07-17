import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/models/get_all_class_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/data/models/get_dashboard_res.dart';

@immutable
abstract class GetAllClassState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetAllClassState {}

class Loading extends GetAllClassState {}

class Loaded extends GetAllClassState {
  final GetAllClassResponseModel? swagger;
  final List<GetAllClassData>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetAllClassState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
