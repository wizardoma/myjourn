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
      yield AuthenticatingState();
      var token = await authenticationService.getToken();
      if (token != null) {
        yield IsAuthenticated(AuthenticationType.user);
      } else {
        yield NotAuthenticated();
      }
    }
    if (event is LoginEvent) {
      yield AuthenticatingState();
      yield await login(event.request);
    }

    if (event is GuestLoginEvent) {
      yield AuthenticatingState();
      authenticationService.loginWithGuest();
      yield IsAuthenticated(AuthenticationType.guest);
    }

    if (event is SignUpEvent) {
      yield AuthenticatingState();
      yield await signUp(event.request);
    }

    if (event is LogoutEvent) {
      yield AuthenticatingState();

      await Future.delayed(Duration(seconds: 5));
      yield await logout();
    }

    if (event is VerifyUniqueEmailEvent) {
      yield AuthenticatingState();
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
        ? IsAuthenticated(AuthenticationType.user)
        : NotAuthenticated.withErrors(response.errors);
  }

  Future<AuthenticationState> login(LoginRequest request) async {
    var response = await authenticationService.login(request);
    return response.statusCode == 200
        ? IsAuthenticated(AuthenticationType.user)
        : NotAuthenticated.withErrors(response.errors);
  }

  Future<AuthenticationState> logout() async {
    await authenticationService.logout();
    return NotAuthenticated();
  }
}
