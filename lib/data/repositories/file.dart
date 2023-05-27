import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as appwirte_models;
import 'package:logger/logger.dart';
import '../providers/file.dart';

class FileRepository {
  final FileAPI fileAPI = FileAPI();

  Future<String> addUserProfilePictureToStorage(
      appwrite.Client client, String userId, String picturePath) async {
    String pictureId = "";
    try {
      final appwirte_models.File result = await fileAPI
          .addUserProfilePictureToStorage(client, userId, picturePath);
      pictureId = result.$id;
      Logger().i("Success add user's profile picture to storage");
    } on appwrite.AppwriteException catch (e) {
      Logger().e("Error while adding user's profile picture to storage: $e");
    }
    return pictureId;
  }

  //TODO view it's necessary to return Future<String>
  Future<String> updateUserProfilePicture(
      appwrite.Client client, String fileId) async {
    String pictureId = "";
    try {
      final appwirte_models.File result =
          await fileAPI.updateUserProfilePicture(client, fileId);
      pictureId = result.$id;
    } on appwrite.AppwriteException catch (e) {
      Logger().e("Error while updating user's profile picture in storage: $e");
    }
    return pictureId;
  }

  Future<void> deleteUserProfilePicture(
      appwrite.Client client, String fileId) async {
    try {
      await fileAPI.deleteUserProfilePicture(client, fileId);
    } on appwrite.AppwriteException catch (e) {
      Logger().e("Error while deleting user's profile picture in storage: $e");
    }
  }
}
