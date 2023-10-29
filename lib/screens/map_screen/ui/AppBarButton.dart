import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppbarButton extends StatelessWidget {
  final IconData icon;

  const AppbarButton({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}