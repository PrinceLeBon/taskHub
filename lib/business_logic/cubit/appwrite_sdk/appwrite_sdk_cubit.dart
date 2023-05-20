import 'package:bloc/bloc.dart';
import 'package:appwrite/appwrite.dart';
import 'package:meta/meta.dart';
import 'package:task_manager/utils/constants.dart';

part 'appwrite_sdk_state.dart';

class AppwriteSdkCubit extends Cubit<AppwriteSdkState> {
  AppwriteSdkCubit() : super(AppwriteSdkInitial());

  void initAppWriteSdk() {
    emit(AppwriteSdkLoading());
    Client client = Client().setEndpoint(endPoint).setProject(projectId);
    final Account account = Account(client);
    emit(AppwriteSdkLoaded(account: account));
  }
}
