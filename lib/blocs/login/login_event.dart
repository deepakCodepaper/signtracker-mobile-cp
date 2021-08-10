import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
  final String countryName;
  final String countryCode;
  final String stateName;
  final String stateCode;

  RegisterButtonPressed({
    @required this.username,
    @required this.password,
    @required this.name,
    @required this.companyName,
    @required this.countryName,
    @required this.countryCode,
    @required this.stateName,
    @required this.stateCode,
  }) : super([
          username,
          password,
          name,
          companyName,
          countryName,
          countryCode,
          stateName,
          stateCode
        ]);

  @override
  String toString() =>
      'RegisterButtonPressed { username: $username, password: $password }';
}
