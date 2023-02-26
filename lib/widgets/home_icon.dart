import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/ColorsRoleSp.dart';

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
    return Container(
      width: 90,
      height: 75,
      decoration: const BoxDecoration(
        color: ColorsRoleSp.blackIcon,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: ColorsRoleSp.whiteLetter),
          const SizedBox(height: 2),
          Text(
            title,
            style:
                const TextStyle(fontSize: 15, color: ColorsRoleSp.whiteLetter),
          ),
        ],
      ),
    );
  }
}
