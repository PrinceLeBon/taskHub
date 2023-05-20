import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' hide Account;
import 'package:task_manager/data/models/user.dart';
import 'package:task_manager/utils/constants.dart';

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

  //TODO pass User as paramaters, get ID.unique in variable, set User.id with ID.unique, pass user as param to addUserToDatabase function
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
      emit(SigningFailed(error: onError));
    });
  }

  Future<void> addUserToDatabase(Client client, User user) async {
    emit(AddingUser());
    final Databases databases = Databases(client);
    try {
      await databases.createDocument(
          databaseId: databaseId,
          collectionId: userCollectionId,
          documentId: user.id,
          data: user.toMap());
      emit(UserAdded());
    } on AppwriteException catch (e) {
      Logger().e("Error while adding user to database: $e");
      emit(AddingUserFailed(error: e.toString()));
    }
  }
}
