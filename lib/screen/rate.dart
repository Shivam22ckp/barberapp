import 'package:barberstar/screen/home.dart';
import 'package:barberstar/service/database.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rate extends StatefulWidget {
  String userid, shopid, username, userimage;
  Rate(
      {required this.shopid,
      required this.userid,
      required this.userimage,
      required this.username});

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  double rating = 0.0;
  TextEditingController userreviewcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(133, 60, 8, 8),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 60.0),
          child: Column(
            children: [
              Text(
                "Thanks! Please rate me",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Rating : $rating',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: RatingBar.builder(
                    unratedColor: Colors.white,
                    itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    minRating: 1.0,
                    updateOnDrag: true,
                    onRatingUpdate: (rating) {
                      setState(() {
                        this.rating = rating;
                      });
                    }),
              ),
              SizedBox(
                height: 90.0,
              ),
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2.0, color: Colors.white),
                ),
                child: TextField(
                    controller: userreviewcontroller,
                    style: TextStyle(color: Colors.white),
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Write a Review",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    )),
              ),
              SizedBox(
                height: 80.0,
              ),
              GestureDetector(
                  onTap: () {
                    Map<String, dynamic> userAddreview = {
                      "Rate": rating,
                      "Review": userreviewcontroller.text,
                      "Name": widget.username,
                      "Image": widget.userimage,
                    };
                    DatabaseMethods().addShopReview(
                        userAddreview, widget.userid, widget.shopid);
                    DatabaseMethods()
                        .addShopPersonalReview(userAddreview, widget.shopid);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Home(distancefilter: 6, pricefilter: "150")));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppWidget.createButton("Add Review"),
                  ))
            ],
          ),
        ));
  }
}
