import 'package:bloc/bloc.dart';
import 'package:appwrite/appwrite.dart';
import 'package:meta/meta.dart';

part 'appwrite_sdk_state.dart';

class AppwriteSdkCubit extends Cubit<AppwriteSdkState> {
  AppwriteSdkCubit() : super(AppwriteSdkInitial());

  void initAppWriteSdk() {
    emit(AppwriteSdkLoading());
    Client client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('6465ff3f354e6a2b9112');
    final Account account = Account(client);
    emit(AppwriteSdkLoaded(account: account));
  }
}
