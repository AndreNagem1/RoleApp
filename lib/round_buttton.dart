import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final double height;
  final double width;
  final Color backGroundColor;
  final Color borderColor;
  final TextStyle font;
  final String text;
  final VoidCallback onPress;

  const RoundButton(
      {Key? key,
      required this.text,
      required this.height,
      required this.width,
      required this.backGroundColor,
      required this.borderColor,
      required this.font,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius:  BorderRadius.all(
          Radius.circular(28),
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => backGroundColor),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Text(
            text,
            style: font,
          ),
        ),
        onPressed: onPress,
      ),
    );
  }
}
