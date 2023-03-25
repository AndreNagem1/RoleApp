import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

class AutoCompleteItem extends StatelessWidget {
  final String? description;
  final VoidCallback onTap;

  const AutoCompleteItem(
      {Key? key, required this.description, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.centerLeft,
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
      ),
    );
  }
}
