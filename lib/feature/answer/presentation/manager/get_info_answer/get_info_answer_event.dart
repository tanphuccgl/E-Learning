import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GetInformationAnswerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetInformationAnswerEventE extends GetInformationAnswerEvent {
  final int? idAnswer;
  final int? idAccount;

  GetInformationAnswerEventE({this.idAnswer, this.idAccount});
}
