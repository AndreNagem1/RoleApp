import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/widgets/hour_item.dart';

class OpeningHoursDialog extends StatelessWidget {
  final List<String>? daysOpeningHours;

  const OpeningHoursDialog({
    Key? key,
    this.daysOpeningHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 410,
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
        child: Column(
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
                'Horários',
                style: GoogleFonts.righteous(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 215,
                child: ListView(
                  children: [
                    HourItem(
                      hour: daysOpeningHours?[0].replaceAll('Monday', 'Seg.').replaceAll('Closed', 'Fechado') ??
                          '',
                    ),
                    HourItem(
                      hour:
                          daysOpeningHours?[1].replaceAll('Tuesday', 'Ter.').replaceAll('Closed', 'Fechado') ??
                              '',
                    ),
                    HourItem(
                      hour: daysOpeningHours?[2]
                              .replaceAll('Wednesday', 'Quart.').replaceAll('Closed', 'Fechado') ??
                          '',
                    ),
                    HourItem(
                      hour: daysOpeningHours?[3]
                              .replaceAll('Thursday', 'Quint.').replaceAll('Closed', 'Fechado') ??
                          '',
                    ),
                    HourItem(
                      hour: daysOpeningHours?[4].replaceAll('Friday', 'Sex.').replaceAll('Closed', 'Fechado') ??
                          '',
                    ),
                    HourItem(
                      hour:
                          daysOpeningHours?[5].replaceAll('Saturday', 'Sab.').replaceAll('Closed', 'Fechado') ??
                              '',
                    ),
                    HourItem(
                      hour: daysOpeningHours?[6].replaceAll('Sunday', 'Dom.').replaceAll('Closed', 'Fechado') ??
                          '',
                      showBottomDivider: false,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
