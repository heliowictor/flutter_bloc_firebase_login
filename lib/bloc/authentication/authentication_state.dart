import 'package:bloc_firebase_login/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  UserModel userModel;
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  UserModel userModel;

  AuthenticationAuthenticated({this.userModel}) {
    super.userModel = this.userModel;
  }

  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}