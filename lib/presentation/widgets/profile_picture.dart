import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import '../../utils/constants.dart';

Storage storage = Storage(client);

class ProfilePicture extends StatelessWidget {
  final double radius;
  final String imageId;

  const ProfilePicture({Key? key, required this.radius, required this.imageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.getFileView(
        bucketId: bucketsUsersProfilePictureId,
        fileId: imageId,
      ),
      builder: (context, snapshot) {
        return (snapshot.hasData && snapshot.data != null)
            ? Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: MemoryImage((snapshot.data)!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : (snapshot.connectionState == ConnectionState.waiting)
                ? const CircularProgressIndicator(
                    color: kPrimaryColor,
                  )
                : Container(
                    width: radius,
                    height: radius,
                    decoration: const BoxDecoration(
                        color: Colors.blueAccent, shape: BoxShape.circle),
                  );
      },
    );
  }
}
