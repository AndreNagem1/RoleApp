import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputText extends StatelessWidget {
  final String hint;
  final Color backgroundColor;
  final Function(String) onTextChange;

  const InputText({super.key, required this.hint, required this.onTextChange, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38),
      ),
      style: GoogleFonts.righteous(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      onChanged: onTextChange,
      keyboardType: TextInputType.number,
    );
  }
}
