class ServerConstants {
  static final baseUrl = "https://myjournserver.herokuapp.com";
  static final journalsUrl = "$baseUrl/journals";

  // auth
  static final authUrl = "$baseUrl/auth";
  static final loginUrl = "$authUrl/login";
  static final signUpUrl = "$authUrl/signup";

  //user
  static final userUrl = "$baseUrl/users";

  static final authHeaderName = "Authorization";
  static final tokenPrefix = "Bearer ";
}
