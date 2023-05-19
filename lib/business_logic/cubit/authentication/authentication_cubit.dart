import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:appwrite/appwrite.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  Future login(Client client, String email, String password) async {
    emit(Login());
    final Account account = Account(client);

    await account
        .createEmailSession(email: email, password: password)
        .then((response) {
      Logger().i("Login successful: $response");
      emit(Logged());
    }).catchError((onError) {
      Logger().e("Error when logging: $onError");
      emit(LoginFailed());
    });
  }

  Future signUp(Client client, String email, String password) async {
    emit(Signing());
    final Account account = Account(client);

    await account
        .create(userId: ID.unique(), email: email, password: password)
        .then((response) {
      Logger().i("Account create successful: $response");
      emit(Signed());
    }).catchError((onError) {
      Logger().e("Error when creating account: $onError");
      emit(SigningFailed());
    });
  }
}
