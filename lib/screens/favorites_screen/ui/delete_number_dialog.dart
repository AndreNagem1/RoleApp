import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

import '../../../widgets/input_text.dart';

class DeleteNumberDialog extends StatelessWidget {
  final VoidCallback onDeleteNumber;

  const DeleteNumberDialog({
    Key? key,
    required this.onDeleteNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: ColorsRoleSp.perfectPurple,
                ),
                child: Text(
                  'Deletar novo lugar',
                  style: GoogleFonts.righteous(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                child: Text(
                  textAlign: TextAlign.center, // Align text to the center
                  'Remover lugar da lista de favorecidos?',
                  style: GoogleFonts.righteous(
                    textStyle:  const TextStyle(
                      fontSize: 18,
                      color: ColorsRoleSp.smoothLetter,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: ColorsRoleSp.perfectPurple,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.black38, width: 2)),
                      child: GestureDetector(
                        onTap: () {
                          onDeleteNumber();
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Deletar',
                              style: GoogleFonts.righteous(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(width: 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cancelar',
                          style: GoogleFonts.righteous(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
