import 'package:flutterfrontend/services/auth/request.dart';

abstract class AuthenticationEvent {
}

class AppStartedEvent extends AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final Request request;

  LoginEvent(this.request);
}
class SignUpEvent extends AuthenticationEvent {
  final Request request;

  SignUpEvent(this.request);

}

class LogoutEvent extends AuthenticationEvent {}

class VerifyUniqueEmailEvent extends AuthenticationEvent {
  final Request request;

  VerifyUniqueEmailEvent(this.request);
}