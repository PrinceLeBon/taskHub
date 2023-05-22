import 'package:logger/logger.dart';
import 'package:task_manager/data/providers/authentication.dart';
import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwirteModels;
import '../models/session.dart';
import '../models/user.dart';

class AuthenticationRepository {
  final AuthenticationAPI authenticationAPI = AuthenticationAPI();

  Future<Session> login(
      Appwrite.Account account, String email, String password) async {
    final sessionFromAppWrite = await authenticationAPI.login(
      account,
      email,
      password,
    );

    final Session session = Session(
      userId: sessionFromAppWrite.userId,
      sessionId: sessionFromAppWrite.$id,
    );

    return session;
  }

  Future<void> signUp(
      Appwrite.Account account, User user, String password) async {
    try {
      await authenticationAPI.signUp(account, user, password);
      final String pictureId = await addUserProfilePictureToStorage(
          account.client, user.id, user.photo);
      user.photo = pictureId;
      await authenticationAPI.addUserToDatabase(account.client, user);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("Error while signing up: $e");
    }
  }

  Future<String> addUserProfilePictureToStorage(
      Appwrite.Client client, String userId, String picturePath) async {
    String pictureId = "";
    try {
      final AppwirteModels.File result = await authenticationAPI
          .addUserProfilePictureToStorage(client, userId, picturePath);
      pictureId = result.$id;
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("Error while adding user's profile picture to storage: $e");
    }
    return pictureId;
  }
}
