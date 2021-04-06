import 'package:flutterfrontend/services/auth/request.dart';

enum SignUpType { email, facebook, google }

class SignUpRequest extends Request{
  final String email;
  final String username;
  final String password;
  final SignUpType signUpType;

  SignUpRequest(this.email,this.username, this.password, this.signUpType);

  static Map<String, dynamic> toMap(SignUpRequest request) {
    print(request.signUpType.toString().split(".").last);
    return {
      "email": request.email,
      "password": request.password,
      "username": request.username,
      "signUpType": request.signUpType.toString().split(".").last
    };
  }
}
