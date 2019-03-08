import 'package:flutter/foundation.dart';

class LoginState {
  final String token;
  final dynamic error;

  const LoginState({ @required this.token, this.error });

  factory LoginState.initial() => LoginState(token: null);
  factory LoginState.success(String token) => LoginState(token: token);
  factory LoginState.failure(dynamic error) => LoginState(token: null, error: error);

  @override
  String toString() => 'LoginState { token: $token }';
}