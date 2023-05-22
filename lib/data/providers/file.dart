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
    );
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
}
