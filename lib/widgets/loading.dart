import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreeen extends StatelessWidget {
  const LoadingScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black45,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              child: Image.asset("assets/gif/splash.gif"),
            ),
          ],
        ),
      ],
    );
  }
}
