import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

class AddFavoritePlaceDialog extends StatelessWidget {
  final String placeName;

  const AddFavoritePlaceDialog({
    Key? key,
    required this.placeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 180,
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
                  'Adicionar novo lugar como favorito',
                  style: GoogleFonts.righteous(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Deseja adicionar ',
                      style: GoogleFonts.righteous(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: ColorsRoleSp.smoothLetter,
                        ),
                      ),
                    ),
                    Text(
                      placeName,
                      style: GoogleFonts.righteous(
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      ' a sua lista',
                      style: GoogleFonts.righteous(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: ColorsRoleSp.smoothLetter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'de favoritos?',
                style: GoogleFonts.righteous(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    color: ColorsRoleSp.smoothLetter,
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
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Adicionar',
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
                    Text(
                      'Cancelar',
                      style: GoogleFonts.righteous(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
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
