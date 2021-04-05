abstract class AuthenticationState {}

class IsAuthenticated extends AuthenticationState {}
class NotAuthenticated extends AuthenticationState {
  final Map<String, String> errors;
  NotAuthenticated(this.errors);
}

class EmailIsAvailableState extends AuthenticationState{}
class EmailNotAvailableState extends AuthenticationState {}