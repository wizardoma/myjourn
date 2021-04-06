mixin ResponseUtil {
  static bool isOk(int code) {
    return code == 200;
  }

  static bool isCreated(int code) {
    return code == 201;
  }

  static bool isAuthorizationError(int code) {
    return code == 401 || code == 403;
  }

  static bool isServerProblem(int code) {
    return code == 500;
  }
}