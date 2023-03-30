import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/dialogs/add_review_dialog.dart';
import 'package:rolesp/models/place_details_response.dart';
import 'package:rolesp/models/review_model.dart';
import 'package:rolesp/widgets/review_widget.dart';

class ReviewsPageBottomSheet extends StatelessWidget {
  final List<Reviews>? listReviews;

  const ReviewsPageBottomSheet({Key? key, required this.listReviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 400,
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
                  height: 350,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return Column(
                        children: [
                          ReviewWidget(
                            userName: listReviews?[position].authorName ?? 'Sem nome' ,
                            reviewText: listReviews?[position].text ?? 'Sem texto',
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
                    itemCount: listReviews?.length,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 400,
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
      builder: (_) => const Center(
        child: SizedBox(
          height: 300,
          child: AddReviewDialog(),
        ),
      ),
    );
  }
}
