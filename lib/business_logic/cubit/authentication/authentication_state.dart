part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class Login extends AuthenticationState {}

class Logged extends AuthenticationState {
  final Session session;

  Logged({required this.session});
}

class LoginFailed extends AuthenticationState {}

class Signing extends AuthenticationState {}

class Signed extends AuthenticationState {}

class SigningFailed extends AuthenticationState {}
