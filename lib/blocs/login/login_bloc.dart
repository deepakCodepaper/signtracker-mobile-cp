import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:signtracker/api/model/login.dart';
import 'package:signtracker/blocs/auth/authentication_bloc.dart';
import 'package:signtracker/repository/user_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository;

  LoginBloc(this.authenticationBloc, this.userRepository)
      : assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  void loginButtonPressed(String username, String password) {
    add(LoginButtonPressed(
      username: username,
      password: password,
    ));
  }

  void registerButtonPressed(
      String username,
      String password,
      String name,
      String companyName,
      String countryName,
      String countryCode,
      String stateName,
      String stateCode) {
    add(RegisterButtonPressed(
        username: username,
        password: password,
        name: name,
        companyName: companyName,
        countryName: countryName,
        countryCode: countryCode,
        stateName: stateName,
        stateCode: stateCode));
  }

  String validateLogin(String username, String password) {
    if (username.isEmpty) return 'Username is required!';
    if (password.isEmpty) return 'Password is required!';
    return null;
  }

  String validateRegister(String username, String password, String name,
      String companyName, String countryCode, String stateCode) {
    if (username.isEmpty) return 'Username is required!';
    if (password.isEmpty) return 'Password is required!';
    if (name.isEmpty) return 'Name is required!';
    if (companyName.isEmpty) return 'Company Name is required!';
    if (countryCode.isEmpty) return 'Country is required!';
    if (stateCode.isEmpty) return 'State is required!';
    return null;
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      final validationMessage = validateLogin(event.username, event.password);
      if (validationMessage?.isNotEmpty == true) {
        yield ValidationFailure(error: validationMessage);
      } else {
        yield LoginLoading();
        final loginResult = await authenticationBloc.authenticate(
            event.username, event.password);
        if (loginResult is Login) {
          final status =
              await OneSignal.shared.getPermissionSubscriptionState();
          final test = await userRepository
              .registerDevice(status.subscriptionStatus.userId);
          print(test);
          yield LoginSuccess();
        } else
          yield LoginFailure(error: loginResult ?? 'Login Failed');
      }
    }

    if (event is RegisterButtonPressed) {
      final validationMessage = validateRegister(event.username, event.password,
          event.name, event.companyName, event.countryCode, event.stateCode);
      if (validationMessage?.isNotEmpty == true) {
        yield ValidationFailure(error: validationMessage);
      } else {
        yield LoginLoading();
        final login = await authenticationBloc.register(
            event.username,
            event.password,
            event.name,
            event.companyName,
            event.countryName,
            event.countryCode,
            event.stateName,
            event.stateCode);
        if (login) {
          yield LoginSuccess();
        } else
          yield LoginFailure(
              error: 'Either the email or company name is taken.');
      }
    }
  }
}
