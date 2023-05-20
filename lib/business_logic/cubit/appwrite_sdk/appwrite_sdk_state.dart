part of 'appwrite_sdk_cubit.dart';

@immutable
abstract class AppwriteSdkState {
  const AppwriteSdkState();
}

class AppwriteSdkInitial extends AppwriteSdkState {}

class AppwriteSdkLoading extends AppwriteSdkState {}

class AppwriteSdkLoaded extends AppwriteSdkState {
  final Account account;

  const AppwriteSdkLoaded({required this.account});
}
