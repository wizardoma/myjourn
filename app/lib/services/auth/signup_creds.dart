enum SignUpType { email, facebook, google }

class SignUpRequest {
  final String email;
  final String password;
  final SignUpType signUpType;

  SignUpRequest(this.email, this.password, this.signUpType);

  static Map<String, dynamic> toMap(SignUpRequest request) {
    return {
      "email": request.email,
      "password": request.password,
      "signUpType": request.signUpType.toString()
    };
  }
}
