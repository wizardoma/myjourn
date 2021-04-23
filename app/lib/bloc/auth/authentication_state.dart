abstract class AuthenticationState {}

class AuthenticationNotInitialized extends AuthenticationState {}
class IsAuthenticated extends AuthenticationState {
  final AuthenticationType authenticationType;

  IsAuthenticated(this.authenticationType);
}
class IsGuestAuthenticated extends AuthenticationState {}
class NotAuthenticated extends AuthenticationState {
  Map<String, dynamic> errors;
  NotAuthenticated(){this.errors = null;}
  NotAuthenticated.withErrors(this.errors);
}
class AuthenticatingState extends AuthenticationState{}
class EmailIsAvailableState extends AuthenticationState{}
class EmailNotAvailableState extends AuthenticationState {

}
enum AuthenticationType {user, guest}