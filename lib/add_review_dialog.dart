import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/round_buttton.dart';

class AddReviewDialog extends StatelessWidget {
  const AddReviewDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
    List<String> spinnerItems = ['1.0', '2.0', '3.0', '4.0', '5.0'];

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 200,
        color: Colors.white,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('O que você achou desse lugar :'),
              Container(
                height: 70,
                width: double.infinity,
              ),
              Row(
                children: const [
                  Text('Nota:'),
                  // DropdownButton(
                  //   value: dropdownValue,
                  //   items: spinnerItems.map<DropdownMenuItem<String>>((value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  //   onChanged: (value) {},
                  // )
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundButton(
                    height: 40,
                    width: 110,
                    onPress: () {},
                    text: 'Avaliar',
                    backGroundColor: const Color.fromARGB(176, 255, 255, 255),
                    borderColor: Colors.black,
                    font: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
