class LoginRequest {
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