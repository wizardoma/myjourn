import 'package:flutterfrontend/services/auth/request.dart';

class LoginRequest  extends Request{
  final String email;
  final String password;

  LoginRequest(this.email, this.password);

  static Map<String, dynamic> toMap(LoginRequest loginCreds) {
    return {
      "email": loginCreds.email,
      "password": loginCreds.password,
    };
  }


}