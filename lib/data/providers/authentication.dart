import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:logger/logger.dart';
import '../../utils/constants.dart';
import '../models/user.dart';

class AuthenticationAPI {
  Future<appwrite_models.Session> login(
      appwrite.Account account, String email, String password) async {
    final appwrite_models.Session session =
        await account.createEmailSession(email: email, password: password);

    return session;
  }

  Future<appwrite_models.Account> signUp(
      appwrite.Account account, User user, String password) async {
    final appwrite_models.Account accountFromAppwrite = await account.create(
        userId: user.id,
        email: user.email,
        password: password,
        name: user.name);

    return accountFromAppwrite;
  }

  Future<void> addUserToDatabase(appwrite.Client client, User user) async {
    try {
      final appwrite.Databases databases = appwrite.Databases(client);
      await databases.createDocument(
          databaseId: databaseId,
          collectionId: userCollectionId,
          documentId: user.id,
          data: user.toMap(),
          permissions: [
            appwrite.Permission.read(appwrite.Role.any()),
            appwrite.Permission.write(appwrite.Role.any()),
            appwrite.Permission.update(appwrite.Role.any()),
            appwrite.Permission.delete(appwrite.Role.any()),
          ]);
    } on appwrite.AppwriteException catch (e) {
      Logger().e("Error while adding user to database: $e");
    }
  }
}
