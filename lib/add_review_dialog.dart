import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/round_buttton.dart';

class AddReviewDialog extends StatefulWidget {
  const AddReviewDialog({Key? key}) : super(key: key);

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  List<String> spinnerItems = <String>['1.0', '2.0', '3.0', '4.0', '5.0'];
  String dropdownValue = '1.0';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 300,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'O que você achou desse lugar :',
                    style: GoogleFonts.righteous(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    )),
                  ),
                  style: GoogleFonts.righteous(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nota:',
                        style: GoogleFonts.righteous(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton(
                        style: GoogleFonts.righteous(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                        value: dropdownValue,
                        items:
                            spinnerItems.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                      )
                    ],
                  ),
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
                      font: GoogleFonts.righteous(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
