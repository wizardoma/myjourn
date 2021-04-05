import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/auth/authentication_event.dart';
import 'package:flutterfrontend/bloc/auth/authentication_state.dart';
import 'package:flutterfrontend/bloc/journal/journal_state.dart';
import 'package:flutterfrontend/services/auth/authentication_service.dart';
import 'package:flutterfrontend/services/auth/login_creds.dart';
import 'package:flutterfrontend/services/auth/signup_creds.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationService _authenticationService = AuthenticationService();
  AuthenticationState authenticationState;

  AuthenticationBloc(AuthenticationState initialState) : super(initialState);

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoginEvent) {
      yield FetchingDataState();
      yield await login(event.email, event.password);
    }

    if (event is SignUpEvent) {
      yield FetchingDataState();
      yield await signUp(event.email, event.password, event.signUpType);
    }

    if (event is LogoutEvent) {
      yield FetchingDataState();
      yield await logout();
    }

    if (event is VerifyUniqueEmailEvent) {
      print("It is verify email");
      yield FetchingDataState();
      yield await verifyUniqueEmail(event);
    }
  }

  Future<AuthenticationState> verifyUniqueEmail(
      VerifyUniqueEmailEvent event) async {
    var response = await _authenticationService.verifyUniqueEmail(event.email);
    if (response.statusCode == 200) {
      print("email is valid");
      return EmailIsAvailableState();
    }
    print("email is not available");
    return EmailNotAvailableState();
  }

  Future<AuthenticationState> signUp(
      String email, String password, String signUpType) async {
    var signUpTypeEnum = SignUpType.values
        .firstWhere((element) => element.toString() == signUpType);
    var response = await _authenticationService
        .signUp(SignUpRequest(email, password, signUpTypeEnum));
    return response.statusCode == 201
        ? IsAuthenticated()
        : NotAuthenticated(response.errors);
  }

  Future<AuthenticationState> login(String email, String password) async {
    var response =
        await _authenticationService.login(LoginRequest(email, password));
    return response.statusCode == 200
        ? IsAuthenticated()
        : NotAuthenticated(response.errors);
  }

  Future<AuthenticationState> logout() async {
    await _authenticationService.logout();
    return NotAuthenticated(null);
  }
}
