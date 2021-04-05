class ServerConstants {
  static final baseUrl = "http://myjournserver.herokuapp.com";
  static final journalsUrl = "$baseUrl/journals";
  static final String authUrl = "$baseUrl/auth";
  static final loginUrl = "$authUrl/login";
  static final signUpUrl = "$authUrl/signup";
  static final authHeaderName = "Authorization";
  static final tokenPrefix= "Bearer ";



}