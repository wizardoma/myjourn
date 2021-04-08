mixin ResponseUtil {
  bool isOk(int code) {
    return code == 200;
  }

  bool isCreated(int code) {
    return code == 201;
  }

  bool isAuthorizationError(int code) {
    return code == 401 || code == 403;
  }

  bool isServerProblem(int code) {
    return code == 500;
  }
}