import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/add_review_dialog.dart';
import 'package:rolesp/models/review_model.dart';
import 'package:rolesp/widgets/review_widget.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    ReviewModel firstReview = ReviewModel(
      userName: 'João',
      reviewText: 'Muito bom, a cerveja está sempre gelada',
    );
    ReviewModel secondReview = ReviewModel(
      userName: 'João',
      reviewText: 'Muito bom, a cerveja está sempre gelada',
    );
    ReviewModel thirdReview = ReviewModel(
      userName: 'João',
      reviewText: 'Muito bom, a cerveja está sempre gelada',
    );
    ReviewModel fourthReview = ReviewModel(
      userName: 'João',
      reviewText: 'Muito bom, a cerveja está sempre gelada',
    );
    ReviewModel fiveReview = ReviewModel(
      userName: 'João',
      reviewText: 'Muito bom, a cerveja está sempre gelada',
    );
    ReviewModel sixReview = ReviewModel(
      userName: 'João',
      reviewText: 'Muito bom, a cerveja está sempre gelada',
    );
    List<ReviewModel> reviewsList = [
      firstReview,
      secondReview,
      thirdReview,
      fourthReview,
      fiveReview,
      sixReview,
    ];

    return Stack(
      children: [
        Container(
          height: screenHeight * 0.7,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 12.0),
                      child: Text(
                        'Reviews',
                        style: GoogleFonts.righteous(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    const Icon(Icons.keyboard_arrow_down_rounded)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: SizedBox(
                  height: screenHeight * 0.6,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return Column(
                        children: [
                          ReviewWidget(
                            userName: reviewsList[position].userName,
                            reviewText: reviewsList[position].reviewText,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 2.0, right: 8.0, bottom: 2.0),
                            child: Container(
                              color: Colors.purpleAccent,
                              height: 0.5,
                              width: double.infinity,
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: reviewsList.length,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: screenHeight * 0.7,
          width: double.infinity,
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FloatingActionButton(
              onPressed: () {
                openAddReviewDialog(context);
              },
              child: const Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }

  openAddReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) =>  Center(
        child:  Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: const AddReviewDialog(),
          ),
        ),
      ),
    );
  }
}
