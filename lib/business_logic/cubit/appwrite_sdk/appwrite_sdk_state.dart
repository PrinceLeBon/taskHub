part of 'appwrite_sdk_cubit.dart';

@immutable
abstract class AppwriteSdkState {}

class AppwriteSdkInitial extends AppwriteSdkState {}

class AppwriteSdkLoading extends AppwriteSdkState {}

class AppwriteSdkLoaded extends AppwriteSdkState {
  final Account account;

  AppwriteSdkLoaded({required this.account});
}
