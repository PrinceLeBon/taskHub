import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import 'package:logger/logger.dart';
import '../../utils/constants.dart';
import '../models/user.dart';

class AuthenticationAPI {
  Future<AppwriteModels.Session> login(
      Appwrite.Account account, String email, String password) async {
    final AppwriteModels.Session session =
        await account.createEmailSession(email: email, password: password);

    return session;
  }

  Future<AppwriteModels.Account> signUp(
      Appwrite.Account account, User user, String password) async {
    final AppwriteModels.Account accountFromAppwrite = await account.create(
        userId: user.id,
        email: user.email,
        password: password,
        name: user.name);

    return accountFromAppwrite;
  }

  Future<void> addUserToDatabase(Appwrite.Client client, User user) async {
    try {
      final Appwrite.Databases databases = Appwrite.Databases(client);
      await databases.createDocument(
          databaseId: databaseId,
          collectionId: userCollectionId,
          documentId: user.id,
          data: user.toMap());
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("Error while adding user to database: $e");
    }
  }
}
