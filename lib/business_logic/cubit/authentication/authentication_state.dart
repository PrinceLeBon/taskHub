part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {}

class Login extends AuthenticationState {}

class Logged extends AuthenticationState {
  final Session session;

  const Logged({required this.session});
}

class LoginFailed extends AuthenticationState {}

class Signing extends AuthenticationState {}

class Signed extends AuthenticationState {}

class SigningFailed extends AuthenticationState {
  final String error;

  const SigningFailed({required this.error});
}

class AddingUser extends AuthenticationState {}

class UserAdded extends AuthenticationState {}

class AddingUserFailed extends AuthenticationState {
  final String error;

  const AddingUserFailed({required this.error});
}
