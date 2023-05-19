import 'package:flutter/material.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/constants.dart';

class Great extends StatelessWidget {
  const Great({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (DateTime.now().hour >= 12)
        ? (DateTime.now().hour >= 18)
            ? const Text(
                'Good \nEvening',
                style: TextStyle(
                    color: kPrimaryColor, fontSize: 60, letterSpacing: 2),
              )
            : const Text('Good \nAfternoon',
                style: TextStyle(
                    color: kPrimaryColor, fontSize: 60, letterSpacing: 2))
        : const Text('Good \nMorning',
            style: TextStyle(
                color: kPrimaryColor, fontSize: 60, letterSpacing: 2));
  }
}
