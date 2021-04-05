import 'package:flutterfrontend/services/auth/request.dart';

class VerifyEmailRequest extends Request{
  final String email;

  VerifyEmailRequest(this.email);
}