import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/screens/map_screen/ui/filter_bottom_sheet.dart';

class AppbarButton extends StatelessWidget {
  final IconData icon;

  const AppbarButton({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return const FilterBottomSheet();
            });
      },
      child: SizedBox(
        width: 70,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 33,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
