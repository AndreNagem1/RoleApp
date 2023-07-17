import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

class HomeSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  final Function(String) onSubmitted;
  final VoidCallback onTap;
  final TextEditingController controller;

  const HomeSearchBar({
    Key? key,
    required this.onSearch,
    required this.onSubmitted,
    required this.controller,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          const SizedBox(width: 10),
          const Icon(
            Icons.search,
            size: 30,
            color: ColorsRoleSp.white,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              onTap: onTap,
              controller: controller,
              cursorColor: ColorsRoleSp.whiteLetter,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: ColorsRoleSp.whiteLetter,
              ),
              decoration: InputDecoration(
                hintText: ' Vamonos aonde?',
                hintStyle: GoogleFonts.righteous(
                  fontSize: 14,
                  color: ColorsRoleSp.whiteLetter,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorsRoleSp.whiteLetter),
                ),
              ),
              onChanged: onSearch,
              onSubmitted: (text) {
                controller.clear();
                onSubmitted(text);
              },
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
