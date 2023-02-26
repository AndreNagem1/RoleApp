import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/ColorsRoleSp.dart';

class HomeGradientEffect extends StatelessWidget {
  const HomeGradientEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          color: Colors.black12,
        ),
        Container(
          width: double.infinity,
          height: 100,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorsRoleSp.background12,
                ColorsRoleSp.background,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
