import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import '../../utils/constants.dart';

class FileAPI {
  Future<AppwriteModels.File> addUserProfilePictureToStorage(
      Appwrite.Client client, String userId, String picturePath) async {
    Appwrite.Storage storage = Appwrite.Storage(client);
    final AppwriteModels.File result = await storage.createFile(
        bucketId: bucketsUsersProfilePictureId,
        fileId: Appwrite.ID.unique(),
        file: Appwrite.InputFile.fromPath(
          path: picturePath,
          filename: '$userId.jpg',
        ),
        permissions: [
          Appwrite.Permission.read(Appwrite.Role.any()),
          Appwrite.Permission.write(Appwrite.Role.any()),
          Appwrite.Permission.update(Appwrite.Role.any()),
          Appwrite.Permission.delete(Appwrite.Role.any()),
        ]);
    return result;
  }

  //TODO view it's necessary to return Future<AppwriteModels.File>
  Future<AppwriteModels.File> updateUserProfilePicture(
      Appwrite.Client client, String fileId) async {
    Appwrite.Storage storage = Appwrite.Storage(client);
    final AppwriteModels.File result = await storage.updateFile(
      bucketId: bucketsUsersProfilePictureId,
      fileId: fileId,
    );
    return result;
  }

  Future<void> deleteUserProfilePicture(
      Appwrite.Client client, String fileId) async {
    Appwrite.Storage storage = Appwrite.Storage(client);
    await storage.deleteFile(
      bucketId: bucketsUsersProfilePictureId,
      fileId: fileId,
    );
  }
}
