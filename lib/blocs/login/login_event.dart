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
  final String mobile;
  final String companyCode;
  final String countryName;
  final String countryCode;
  final String stateName;
  final String stateCode;
  final String city;
  final String street_address;

  RegisterButtonPressed({
    @required this.username,
    @required this.password,
    @required this.name,
    @required this.mobile,
    @required this.companyCode,
    @required this.countryName,
    @required this.countryCode,
    @required this.stateName,
    @required this.stateCode,
    @required this.city,
    @required this.street_address,
  }) : super([
          username,
          password,
          name,
          mobile,
          companyCode,
          countryName,
          countryCode,
          stateName,
          stateCode,
          city,
          street_address
        ]);

  @override
  String toString() =>
      'RegisterButtonPressed { username: $username, password: $password }';
}

class ResetPasswordButtonPressed extends LoginEvent {
  final String email;

  ResetPasswordButtonPressed({@required this.email}) : super([email]);

  @override
  String toString() => 'ResetPasswordButtonPressed { email: $email }';
}
