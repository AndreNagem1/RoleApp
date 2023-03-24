import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

class AutoCompleteItem extends StatelessWidget {
  final String? description;

  const AutoCompleteItem({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          description ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorsRoleSp.whiteLetter,
          ),
        ),
      ),
    );
  }
}
