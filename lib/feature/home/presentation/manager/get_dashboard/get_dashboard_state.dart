import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/data/models/get_dashboard_res.dart';

@immutable
abstract class GetDashboardState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends GetDashboardState {}

class Loading extends GetDashboardState {}

class Loaded extends GetDashboardState {
  final GetDashboardResponse? swagger;
  final GetDashboardData? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends GetDashboardState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
