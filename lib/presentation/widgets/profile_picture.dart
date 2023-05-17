import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double radius;
  final String image;

  const ProfilePicture({Key? key, required this.radius, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
