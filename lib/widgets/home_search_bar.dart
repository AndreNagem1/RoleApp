import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback navigateToHome;

  const HomeSearchBar({
    Key? key,
    required this.navigateToHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToHome,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: ColorsRoleSp.searchBorder,
          ),
          color: ColorsRoleSp.blackIcon,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: const [
            SizedBox(width: 10),
            Icon(
              Icons.search,
              size: 30,
              color: ColorsRoleSp.white,
            ),
          ],
        ),
      ),
    );
  }
}
