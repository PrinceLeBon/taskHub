import 'package:logger/logger.dart';
import 'package:task_manager/data/providers/authentication.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as AppwriteModels;
import 'package:task_manager/data/repositories/file.dart';
import '../models/session.dart';
import '../models/user.dart';

class AuthenticationRepository {
  final AuthenticationAPI authenticationAPI = AuthenticationAPI();

  Future<Session> login(Account account, String email, String password) async {
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

  Future<void> signUp(Account account, User user, String password) async {
    try {
      final FileRepository fileRepository = FileRepository();

      final AppwriteModels.Account aaccount =
          await authenticationAPI.signUp(account, user, password);

      user.id = aaccount.$id;

      final String pictureId = await fileRepository
          .addUserProfilePictureToStorage(account.client, user.id, user.photo);
      user.photo = pictureId;

      await authenticationAPI.addUserToDatabase(account.client, user);
    } on AppwriteException catch (e) {
      Logger().e("Error while signing up: $e");
    }
  }
}
