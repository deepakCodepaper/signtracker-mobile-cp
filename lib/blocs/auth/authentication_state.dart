import 'package:built_value/built_value.dart';
import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/login.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super([props]);
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}
