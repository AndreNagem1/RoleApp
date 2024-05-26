import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Resources/ColorsRoleSp.dart';

class FilterDistanceDraggable extends StatefulWidget {
  const FilterDistanceDraggable(
      {super.key,
      required this.setNewDistance,
      required this.selectedDistanceFilterOnScreen});

  final void Function(double) setNewDistance;
  final double selectedDistanceFilterOnScreen;

  @override
  State<FilterDistanceDraggable> createState() =>
      _FilterDistanceDraggableState();
}

class _FilterDistanceDraggableState extends State<FilterDistanceDraggable> {
  var offSetAxisX = 0.0;
  var draggablePosition = 1;
  var screenWidth = 330.0;

  @override
  void initState() {
    super.initState();

    if (widget.selectedDistanceFilterOnScreen == 500.0) {
      draggablePosition = 1;
      offSetAxisX = 0.0;
    }

    if (widget.selectedDistanceFilterOnScreen == 1000.0) {
      draggablePosition = 2;
      offSetAxisX = (screenWidth / 2) - 10;
    }

    if (widget.selectedDistanceFilterOnScreen == 1500.0) {
      draggablePosition = 3;
      offSetAxisX = screenWidth - 18;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (offSetAxisX < screenWidth / 4) {
      draggablePosition = 1;
      offSetAxisX = 0.0;
    }

    if (offSetAxisX > screenWidth / 4 && offSetAxisX < screenWidth * 3 / 4) {
      draggablePosition = 2;
      offSetAxisX = (screenWidth / 2) - 10;
    }

    if (offSetAxisX > screenWidth * 3 / 4) {

    }

    return Stack(
      children: [
        DraggableInitialState(
          postion: draggablePosition,
          setFirstPosition: () {
            draggablePosition = 1;
            offSetAxisX = 0.0;
            widget.setNewDistance(500);
          },
          setSecondPosition: () {
            draggablePosition = 2;
            offSetAxisX = (screenWidth / 2) - 10;
            widget.setNewDistance(1000);
          },
          setThirdPosition: () {
            draggablePosition = 3;
            offSetAxisX = screenWidth - 18;
            widget.setNewDistance(1500);
          },
        ),
        Positioned(
          left: offSetAxisX,
          child: Draggable(
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsRoleSp.secondaryColorDark),
            ),
            feedback: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsRoleSp.secondaryColorDark),
            ),
            onDragEnd: (dragDetails) {
              setState(() {
                offSetAxisX = dragDetails.offset.dx;

                if (offSetAxisX < screenWidth / 4) {
                  widget.setNewDistance(500);
                }

                if (offSetAxisX > screenWidth / 4 &&
                    offSetAxisX < screenWidth * 3 / 4) {
                  widget.setNewDistance(1000);
                }

                if (offSetAxisX > screenWidth * 3 / 4) {
                  widget.setNewDistance(1500);
                }
              });
            },
            axis: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}

class DraggableInitialState extends StatelessWidget {
  const DraggableInitialState(
      {super.key,
      required this.postion,
      required this.setFirstPosition,
      required this.setSecondPosition,
      required this.setThirdPosition});

  final void Function() setFirstPosition;
  final void Function() setSecondPosition;
  final void Function() setThirdPosition;

  final int postion;

  @override
  Widget build(BuildContext context) {
    final isPositionOne = postion == 1;
    final isPositionTwo = postion == 2;
    final isPositionThree = postion == 3;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          const Divider(
            color: ColorsRoleSp.secondaryColorDark,
            thickness: 4.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isPositionOne)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '5 Km',
                    style: GoogleFonts.notoSans(
                        color: ColorsRoleSp.whiteLetterNew,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              if (!isPositionOne)
                GestureDetector(
                  onTap: setFirstPosition,
                  child: Text(
                    '5 Km',
                    style: GoogleFonts.notoSans(
                        color: ColorsRoleSp.unselectedLetter,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              if (isPositionTwo)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '10 Km',
                    style: GoogleFonts.notoSans(
                        color: ColorsRoleSp.whiteLetterNew,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              if (!isPositionTwo)
                GestureDetector(
                  onTap: setSecondPosition,
                  child: Text(
                    '10 Km',
                    style: GoogleFonts.notoSans(
                        color: ColorsRoleSp.unselectedLetter,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              if (isPositionThree)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '15 Km',
                    style: GoogleFonts.notoSans(
                        color: ColorsRoleSp.whiteLetterNew,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              if (!isPositionThree)
                GestureDetector(
                  onTap: setThirdPosition,
                  child: Text(
                    '15 Km',
                    style: GoogleFonts.notoSans(
                        color: ColorsRoleSp.unselectedLetter,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
