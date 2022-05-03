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
      String mobile,
      String companyCode,
      String countryName,
      String countryCode,
      String stateName,
      String stateCode) {
    add(RegisterButtonPressed(
        username: username,
        password: password,
        name: name,
        mobile: mobile,
        companyCode: companyCode,
        countryName: countryName,
        countryCode: countryCode,
        stateName: stateName,
        stateCode: stateCode));
  }

  void resetPasswordButtonPressed(String email) {
    add(ResetPasswordButtonPressed(email: email));
  }

  String validateLogin(String username, String password) {
    if (username.isEmpty) return 'Username is required!';
    if (password.isEmpty) return 'Password is required!';
    return null;
  }

  String validateRegister(
    String username,
    String password,
    String name,
    String mobile,
    String companyCode,
    String countryCode,
    String stateCode,
  ) {
    if (name.isEmpty) return 'Name is required!';
    if (username.isEmpty) return 'Username is required!';
    if (password.isEmpty) return 'Password is required!';
    if (mobile.isEmpty) return 'Mobile number is required!';
    if (companyCode.isEmpty) return 'Company code is required!';
    if (countryCode.isEmpty) return 'Country is required!';
    if (stateCode.isEmpty) return 'State is required!';
    return null;
  }

  String validateResetPassword(String email) {
    if (email.isEmpty) return 'Email is required!';
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
          //final status = await OneSignal.shared.getPermissionSubscriptionState();
          final status = await OneSignal.shared.getDeviceState();
          //final test = await userRepository.registerDevice(status.subscriptionStatus.userId);
          final test = await userRepository.registerDevice(status.userId);
          print(test);
          yield LoginSuccess();
        } else
          yield LoginFailure(error: loginResult ?? 'Login Failed');
      }
    }

    if (event is RegisterButtonPressed) {
      final validationMessage = validateRegister(
          event.username,
          event.password,
          event.name,
          event.mobile,
          event.companyCode,
          event.countryCode,
          event.stateCode);
      if (validationMessage?.isNotEmpty == true) {
        yield ValidationFailure(error: validationMessage);
      } else {
        yield LoginLoading();
        final login = await authenticationBloc.register(
            event.username,
            event.password,
            event.name,
            event.mobile,
            event.companyCode,
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

    if (event is ResetPasswordButtonPressed) {
      final validationMessage = validateResetPassword(event.email);
      if (validationMessage?.isNotEmpty == true) {
        yield ValidationFailure(error: validationMessage);
      } else {
        yield LoginLoading();
        final result = await authenticationBloc.resetPassword(event.email);
        if (result) {
          yield LoginInfo(
              info: 'You will receive an email to reset your password.');
        } else {
          yield LoginFailure(
              error:
                  'Failed to reset password. Please make sure your email is correct.');
        }
      }
    }
  }
}
