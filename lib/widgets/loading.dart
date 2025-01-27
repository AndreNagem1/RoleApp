import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:shimmer/shimmer.dart';

import '../screens/events_screen/ui/events_background.dart';

class EventsLoadingScreen extends StatelessWidget {
  const EventsLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: 3,
      padding: const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0), // Added top padding
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Shimmer.fromColors(
            baseColor: ColorsRoleSp.smoothLetter.withOpacity(0.2),
            highlightColor: Colors.white.withOpacity(0.2),
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        );
      },
    );
  }
}

