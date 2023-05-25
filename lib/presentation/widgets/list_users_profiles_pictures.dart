import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/profile_picture.dart';

class ListUserInABoard extends StatelessWidget {
  final List<String> listOfUsersPhoto;

  const ListUserInABoard({Key? key, required this.listOfUsersPhoto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (listOfUsersPhoto.isNotEmpty)
        ? SizedBox(
            width: (listOfUsersPhoto.length == 1)
                ? 60
                : (listOfUsersPhoto.length == 2)
                    ? 90
                    : (listOfUsersPhoto.length == 3)
                        ? 120
                        : (listOfUsersPhoto.length == 4)
                            ? 150
                            : 180,
            height: 50,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: ProfilePicture(
                    radius: 50,
                    imageId: listOfUsersPhoto[0],
                  ),
                ),
                (listOfUsersPhoto.length >= 2)
                    ? Positioned(
                        left: 40,
                        bottom: 0,
                        child: ProfilePicture(
                          radius: 50,
                          imageId: listOfUsersPhoto[1],
                        ),
                      )
                    : Container(),
                (listOfUsersPhoto.length >= 3)
                    ? Positioned(
                        left: 70,
                        bottom: 0,
                        child: ProfilePicture(
                          radius: 50,
                          imageId: listOfUsersPhoto[2],
                        ),
                      )
                    : Container(),
                (listOfUsersPhoto.length >= 4)
                    ? Positioned(
                        left: 100,
                        bottom: 0,
                        child: ProfilePicture(
                          radius: 50,
                          imageId: listOfUsersPhoto[3],
                        ),
                      )
                    : Container(),
                (listOfUsersPhoto.length >= 5)
                    ? Positioned(
                        left: 130,
                        bottom: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(5, 4, 43, 1),
                              shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              '+${listOfUsersPhoto.length - 4}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        : Container();
  }
}
