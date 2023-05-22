import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwirteModels;
import 'package:logger/logger.dart';
import '../providers/file.dart';

class FileRepository {
  final FileAPI fileAPI = FileAPI();

  Future<String> addUserProfilePictureToStorage(
      Appwrite.Client client, String userId, String picturePath) async {
    String pictureId = "";
    try {
      final AppwirteModels.File result = await fileAPI
          .addUserProfilePictureToStorage(client, userId, picturePath);
      pictureId = result.$id;
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("Error while adding user's profile picture to storage: $e");
    }
    return pictureId;
  }

  //TODO view it's necessary to return Future<String>
  Future<String> updateUserProfilePicture(
      Appwrite.Client client, String fileId) async {
    String pictureId = "";
    try {
      final AppwirteModels.File result =
          await fileAPI.updateUserProfilePicture(client, fileId);
      pictureId = result.$id;
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("Error while updating user's profile picture in storage: $e");
    }
    return pictureId;
  }

  Future<void> deleteUserProfilePicture(
      Appwrite.Client client, String fileId) async {
    try {
      await fileAPI.deleteUserProfilePicture(client, fileId);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("Error while deleting user's profile picture in storage: $e");
    }
  }
}
