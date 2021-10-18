import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginFailure extends LoginState {
  LoginFailure({@required this.error}) : super([error]);

  final String error;

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginSuccess extends LoginState {
  @override
  String toString() => 'LoginSuccess';
}

class ValidationFailure extends LoginState {
  ValidationFailure({@required this.error}) : super([error]);

  final String error;

  @override
  String toString() => 'ValidationFailure { error : $error }';
}

class LoginInfo extends LoginState {
  LoginInfo({@required this.info}) : super([info]);

  final String info;

  @override
  String toString() => 'LoginInfo { info: $info }';
}
