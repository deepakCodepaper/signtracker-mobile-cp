import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/sign.dart';

abstract class AddSignState extends Equatable {
  AddSignState([List props = const []]) : super([props]);

  @override
  String toString() => 'AddSignState';
}

class AddSignInitialState extends AddSignState {
  @override
  String toString() => 'AddSignInitialState';

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddSignUploadingState extends AddSignState {
  @override
  String toString() => 'AddSignUploadingState';

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddSignUploadedState extends AddSignState {
  AddSignUploadedState(this.sign) : super([sign]);

  final Sign sign;

  @override
  String toString() => 'AddSignUploadedState $sign';
}

class AddSignNotUploadedState extends AddSignState {
  AddSignNotUploadedState(this.error) : super([error]);
  final String error;

  @override
  String toString() => 'AddSignNotUploadedState $error';
}
