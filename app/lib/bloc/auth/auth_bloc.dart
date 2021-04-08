import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/auth/authentication_event.dart';
import 'package:flutterfrontend/bloc/auth/authentication_state.dart';
import 'package:flutterfrontend/services/auth/authentication_service.dart';
import 'package:flutterfrontend/services/auth/login_request.dart';
import 'package:flutterfrontend/services/auth/signup_request.dart';
import 'package:flutterfrontend/services/auth/verify_email_request.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;

  AuthenticationBloc({@required this.authenticationService})
      : super(AuthenticationNotInitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStartedEvent) {
      print("app started");
      var token = await authenticationService.getToken();
      if (token == null) {
        yield IsAuthenticated();
      } else {
        yield NotAuthenticated();
      }
    }
    if (event is LoginEvent) {
      yield FetchingDataState();
      yield await login(event.request);
    }

    if (event is SignUpEvent) {
      yield FetchingDataState();
      yield await signUp(event.request);
    }

    if (event is LogoutEvent) {
      yield FetchingDataState();
      yield await logout();
    }

    if (event is VerifyUniqueEmailEvent) {
      yield FetchingDataState();
      yield await verifyUniqueEmail(event.request);
    }
  }

  Future<AuthenticationState> verifyUniqueEmail(
      VerifyEmailRequest request) async {
    var response = await authenticationService.verifyUniqueEmail(request);
    if (response.statusCode == 200) {
      return EmailIsAvailableState();
    }
    return EmailNotAvailableState();
  }

  Future<AuthenticationState> signUp(SignUpRequest request) async {
    var response = await authenticationService.signUp(request);
    return response.statusCode == 201
        ? IsAuthenticated()
        : NotAuthenticated.withErrors(response.errors);
  }

  Future<AuthenticationState> login(LoginRequest request) async {
    var response = await authenticationService.login(request);
    return response.statusCode == 200
        ? IsAuthenticated()
        : NotAuthenticated.withErrors(response.errors);
  }

  Future<AuthenticationState> logout() async {
    await authenticationService.logout();
    return NotAuthenticated();
  }
}
