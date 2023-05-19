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
      Logger().i("Login successful: ${response.userId}");
      Logger().i("Login successful: ${response.clientCode}");
      Logger().i("Login successful: ${response.clientEngine}");
      Logger().i("Login successful: ${response.clientEngineVersion}");
      Logger().i("Login successful: ${response.clientName}");
      Logger().i("Login successful: ${response.clientType}");
      Logger().i("Login successful: ${response.clientVersion}");
      Logger().i("Login successful: ${response.countryCode}");
      Logger().i("Login successful: ${response.countryName}");
      Logger().i("Login successful: ${response.deviceBrand}");
      Logger().i("Login successful: ${response.deviceModel}");
      Logger().i("Login successful: ${response.deviceName}");
      Logger().i("Login successful: ${response.expire}");
      Logger().i("Login successful: ${response.ip}");
      Logger().i("Login successful: ${response.$id}");
      Logger().i("Login successful: ${response.osCode}");
      Logger().i("Login successful: ${response.osName}");
      Logger().i("Login successful: ${response.osVersion}");
      Logger().i("Login successful: ${response.provider}");
      Logger().i("Login successful: ${response.providerAccessToken}");
      Logger().i("Login successful: ${response.providerAccessTokenExpiry}");
      Logger().i("Login successful: ${response.providerRefreshToken}");
      Logger().i("Login successful: ${response.providerUid}");
      Logger().i("Login successful: ${response.$createdAt}");
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
