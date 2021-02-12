import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class CardReviews extends StatelessWidget{

  final CustomerReview customerReview;

  const CardReviews({Key key, this.customerReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,       
        children: [
          Text(
            customerReview.name != null ? customerReview.name : "",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.red,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              customerReview.review != null ? customerReview.review : "",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,),
            ),
          ),
        ],
      )
    );
  }
}