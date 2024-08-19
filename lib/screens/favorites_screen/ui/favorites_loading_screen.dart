import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:shimmer/shimmer.dart';

class FavoritesLoadingScreen extends StatelessWidget {
  const FavoritesLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      padding: const EdgeInsets.only(top: 80.0, left: 16.0, right: 16.0),
      // Added top padding
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Shimmer.fromColors(
            baseColor: ColorsRoleSp.smoothLetter.withOpacity(0.2),
            highlightColor: Colors.white.withOpacity(0.2),
            child: Container(
              height: 100.0,
              width: 320,
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
