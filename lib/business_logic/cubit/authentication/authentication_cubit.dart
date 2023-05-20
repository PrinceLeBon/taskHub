import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' hide Account;

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  Future login(Account account, String email, String password) async {
    emit(Login());
    await account
        .createEmailSession(email: email, password: password)
        .then((response) {
      //TODO see if it is not better to keep only userID and session id
      Logger().i("Login successful userid: ${response.userId}");
      Logger().i("Login successful id: ${response.$id}");
      emit(Logged(session: response));
    }).catchError((onError) {
      Logger().e("Error when logging: $onError");
      emit(LoginFailed());
    });
    Future result = account.get();

    result.then((response) {
      Logger().i("login verifier session active: $response");
    }).catchError((error) {
      Logger().e("login erreur verifier session active: $onError");
    });
  }

  Future signUp(
      Account account, String email, String password, String name) async {
    emit(Signing());
    await account
        .create(
            userId: ID.unique(), email: email, password: password, name: name)
        .then((response) {
      Logger().i("Account create successful: $response");
      emit(Signed());
    }).catchError((onError) {
      Logger().e("Error when creating account: $onError");
      emit(SigningFailed());
    });
  }
}
