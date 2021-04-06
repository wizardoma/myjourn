abstract class AuthenticationState {}

class AuthenticationNotInitialized extends AuthenticationState {}
class IsAuthenticated extends AuthenticationState {}
class NotAuthenticated extends AuthenticationState {
  Map<String, dynamic> errors;
  NotAuthenticated(){this.errors = null;}
  NotAuthenticated.withErrors(this.errors);
}
class FetchingDataState extends AuthenticationState{}
class EmailIsAvailableState extends AuthenticationState{}
class EmailNotAvailableState extends AuthenticationState {

}