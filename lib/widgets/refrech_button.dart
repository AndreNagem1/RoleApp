import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({Key? key}) : super(key: key);

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
        children: const [
          Icon(Icons.refresh_sharp, size: 33, color: ColorsRoleSp.whiteLetter),
          SizedBox(height: 2),
        ],
      ),
    );
  }
}
