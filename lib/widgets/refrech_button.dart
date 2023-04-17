import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

class MapButton extends StatelessWidget {
  final IconData icon;

  const MapButton({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 60,
      decoration: BoxDecoration(
        color: ColorsRoleSp.blackIcon,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          color: ColorsRoleSp.whiteLetter,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Icon(icon, size: 33, color: ColorsRoleSp.whiteLetter),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}
