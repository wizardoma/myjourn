import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/auth/authentication_event.dart';
import 'package:flutterfrontend/bloc/auth/authentication_state.dart';
import 'package:flutterfrontend/services/auth/authentication_service.dart';
import 'package:flutterfrontend/services/auth/login_request.dart';
import 'package:flutterfrontend/services/auth/signup_request.dart';
import 'package:flutterfrontend/services/auth/verify_email_request.dart';

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
      print("It is verify email");
      yield FetchingDataState();
      yield await verifyUniqueEmail(event.request);
    }
  }

  Future<AuthenticationState> verifyUniqueEmail(
      VerifyEmailRequest request) async {
    var response = await _authenticationService.verifyUniqueEmail(request);
    if (response.statusCode == 200) {
      print("email is valid");
      return EmailIsAvailableState();
    }
    print("email is not available");
    return EmailNotAvailableState();
  }

  Future<AuthenticationState> signUp(SignUpRequest request) async {
    var signUpTypeEnum = SignUpType.values
        .firstWhere((element) => element == request.signUpType);
    var response = await _authenticationService
        .signUp(request);
    return response.statusCode == 201
        ? IsAuthenticated()
        : NotAuthenticated(response.errors);
  }

  Future<AuthenticationState> login(LoginRequest request) async {
    var response =
        await _authenticationService.login(request);
    return response.statusCode == 200
        ? IsAuthenticated()
        : NotAuthenticated(response.errors);
  }

  Future<AuthenticationState> logout() async {
    await _authenticationService.logout();
    return NotAuthenticated(null);
  }
}
