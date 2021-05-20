import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
  }) : super([username, password]);

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class RegisterButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final String name;
  final String companyName;

  RegisterButtonPressed({
    @required this.username,
    @required this.password,
    @required this.name,
    @required this.companyName,
  }) : super([username, password, name, companyName]);

  @override
  String toString() =>
      'RegisterButtonPressed { username: $username, password: $password }';
}
