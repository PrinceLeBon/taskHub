import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as appwrite_models;
import '../../utils/constants.dart';

class FileAPI {
  Future<appwrite_models.File> addUserProfilePictureToStorage(
      appwrite.Client client, String userId, String picturePath) async {
    appwrite.Storage storage = appwrite.Storage(client);
    final appwrite_models.File result = await storage.createFile(
        bucketId: bucketsUsersProfilePictureId,
        fileId: appwrite.ID.unique(),
        file: appwrite.InputFile.fromPath(
          path: picturePath,
          filename: '$userId.jpg',
        ),
        permissions: [
          appwrite.Permission.read(appwrite.Role.any()),
          appwrite.Permission.write(appwrite.Role.any()),
          appwrite.Permission.update(appwrite.Role.any()),
          appwrite.Permission.delete(appwrite.Role.any()),
        ]);
    return result;
  }

  //TODO view it's necessary to return Future<appwrite_models.File>
  Future<appwrite_models.File> updateUserProfilePicture(
      appwrite.Client client, String fileId) async {
    appwrite.Storage storage = appwrite.Storage(client);
    final appwrite_models.File result = await storage.updateFile(
      bucketId: bucketsUsersProfilePictureId,
      fileId: fileId,
    );
    return result;
  }

  Future<void> deleteUserProfilePicture(
      appwrite.Client client, String fileId) async {
    appwrite.Storage storage = appwrite.Storage(client);
    await storage.deleteFile(
      bucketId: bucketsUsersProfilePictureId,
      fileId: fileId,
    );
  }
}
