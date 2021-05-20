import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
      String username, String password, String name, String companyName) {
    add(RegisterButtonPressed(
      username: username,
      password: password,
      name: name,
      companyName: companyName,
    ));
  }

  String validateLogin(String username, String password) {
    if (username.isEmpty) return 'Username is required!';
    if (password.isEmpty) return 'Password is required!';
    return null;
  }

  String validateRegister(
      String username, String password, String name, String companyName) {
    if (username.isEmpty) return 'Username is required!';
    if (password.isEmpty) return 'Password is required!';
    if (name.isEmpty) return 'Name is required!';
    if (companyName.isEmpty) return 'Company Name is required!';
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      final validationMessage = validateLogin(event.username, event.password);
      if (validationMessage?.isNotEmpty == true) {
        yield ValidationFailure(error: validationMessage);
      } else {
        yield LoginLoading();
        final login = await authenticationBloc.authenticate(
            event.username, event.password);
        if (login) {
          final status =
              await OneSignal.shared.getPermissionSubscriptionState();
          final test = await userRepository
              .registerDevice(status.subscriptionStatus.userId);
          print(test);
          yield LoginSuccess();
        } else
          yield LoginFailure(error: 'Login Failed');
      }
    }

    if (event is RegisterButtonPressed) {
      final validationMessage = validateRegister(
          event.username, event.password, event.name, event.companyName);
      if (validationMessage?.isNotEmpty == true) {
        yield ValidationFailure(error: validationMessage);
      } else {
        yield LoginLoading();
        final login = await authenticationBloc.register(
            event.username, event.password, event.name, event.companyName);
        if (login) {
          yield LoginSuccess();
        } else
          yield LoginFailure(
              error: 'Either the email or company name is taken.');
      }
    }
  }
}
