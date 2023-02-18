import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  final IconData icon;
  final String title;

  const HomeIcon({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 30,
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
