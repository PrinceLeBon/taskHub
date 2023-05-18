part of 'appwrite_sdk_cubit.dart';

@immutable
abstract class AppwriteSdkState {}

class AppwriteSdkInitial extends AppwriteSdkState {}

class AppwriteSdkLoading extends AppwriteSdkState {}

class AppwriteSdkLoaded extends AppwriteSdkState {
  final Client client;

  AppwriteSdkLoaded({required this.client});
}
