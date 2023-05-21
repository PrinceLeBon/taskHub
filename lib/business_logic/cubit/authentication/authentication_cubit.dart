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
      emit(LoginFailed(error: "Error when logging: $onError"));
    });
  }

  Future signUp(Account account, User user, String password) async {
    emit(Signing());
    final String uniqueId = ID.unique();
    user.id = uniqueId;
    await account
        .create(
            userId: user.id,
            email: user.email,
            password: password,
            name: user.name)
        .then((response) {
      addUserToDatabase(account.client, user);
      Logger().i("Account create successful: $response");
      emit(Signed());
    }).catchError((onError) {
      Logger().e("Error when creating account: $onError");
      emit(SigningFailed(error: "Error when creating account: $onError"));
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
      emit(AddingUserFailed(error: "Error while adding user to database: $e"));
    }
  }
}
