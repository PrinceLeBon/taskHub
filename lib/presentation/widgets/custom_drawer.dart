import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/profile_picture.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(5, 4, 43, 1),
      child: Container(
        margin: MediaQuery.of(context).padding,
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: const ProfilePicture(
                        radius: 50, imageId: "currentUser.photo"),
                    onTap: () {},
                  ),
                  Icon(Icons.blur_circular, color: Colors.yellow[500])
                ],
              ),
              Container(
                height: 20,
              ),
              const Text(
                'currentUser.nomcurrentUser.prenom',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              Container(
                height: 5,
              ),
              const Text(
                '@{currentUser.username}',
                style: TextStyle(color: Colors.white),
              ),
              Container(
                height: 10,
              ),
              Container(
                height: 20,
              ),
              Container(
                height: 1,
                color: Colors.yellow[500],
              ),
              Container(
                height: 30,
              ),
              InkWell(
                child: _childDrawer1(Icons.person_outlined, 'Profile', 18),
                onTap: () {},
              ),
              Container(
                height: 20,
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.yellow[500],
              ),
              Container(
                height: 30,
              ),
              InkWell(
                child: _childDrawer1(Icons.logout, 'Log Out', 18),
                onTap: () {
                  /*FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()));*/
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _childDrawer1(IconData icon, String label, double size) {
    return Row(
      children: [
        Icon(icon, color: Colors.yellow[500]),
        Container(
          width: 10,
        ),
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size,
              color: Colors.white),
        ),
      ],
    );
  }
}
