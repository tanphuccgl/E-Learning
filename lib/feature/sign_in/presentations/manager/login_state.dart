import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/models/login_data.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends LoginState {}

class Loading extends LoginState {}

class Loaded extends LoginState {
  final LoginData data;
  Loaded({required this.data});

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class Error extends LoginState {
  final String message;
  Error({required this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class LoginAlready extends LoginState {}

class NotLogin extends LoginState {}
