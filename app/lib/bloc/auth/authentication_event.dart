abstract class AuthenticationEvent {
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}
class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String signUpType;

  SignUpEvent(this.email, this.password, this.signUpType);

}

class LogoutEvent extends AuthenticationEvent {

}