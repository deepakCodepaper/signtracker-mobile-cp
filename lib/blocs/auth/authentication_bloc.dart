import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  Future<dynamic> authenticate(String username, String password) async {
    return await userRepository.authenticate(
      username: username,
      password: password,
    );
  }

  Future<bool> register(
      String username,
      String password,
      String name,
      String mobile,
      String companyCode,
      String countryName,
      String countryCode,
      String stateName,
      String stateCode, String city,String street_address) async {
    return await userRepository.register(
      username: username,
      password: password,
      name: name,
      mobile: mobile,
      companyCode: companyCode,
      countryName: countryName,
      countryCode: countryCode,
      stateName: stateName,
      stateCode: stateCode,
      city: city,
      street_address: street_address,
    );
  }

  Future<bool> resetPassword(String email) async {
    return await userRepository.resetPassword(email: email);
  }

  Future<bool> isLoggedIn() async {
    return await userRepository.hasToken();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      if (await userRepository.hasToken()) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      final success = await authenticate(event.username, event.password);
      if (success.item1) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
