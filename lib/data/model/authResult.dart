class AuthResult<T> {
  final T? data;
  final String? errorMessage;

  const AuthResult._({this.data, this.errorMessage});

  factory AuthResult.success(T data) => AuthResult._(data: data);
  factory AuthResult.failure(String message) => AuthResult._(errorMessage: message);

  bool get isSuccess => errorMessage == null;
}