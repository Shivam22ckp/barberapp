import 'package:barberstar/service/database.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OwnReview extends StatefulWidget {
  String shopid;
  OwnReview({required this.shopid});

  @override
  State<OwnReview> createState() => _OwnReviewState();
}

class _OwnReviewState extends State<OwnReview> {
  Stream? reviewStream;

  Widget shopList() {
    return StreamBuilder(
        stream: reviewStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  ds["Image"],
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(ds["Name"],
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      )),
                                  SizedBox(
                                    width: 60.0,
                                  ),
                                  for (int i = 1; i <= 5; i++)
                                    if (i <= ds["Rate"])
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 25.0,
                                      )
                                    else
                                      Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                        size: 25.0,
                                      )
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: 250,
                                child: Text(ds["Review"],
                                    maxLines: 5,
                                    style: TextStyle(color: Colors.grey[300])),
                              )
                            ],
                          ),
                        ]);
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  getheDetail() async {
    reviewStream = await DatabaseMethods().getUserShopsReviews(widget.shopid);
    setState(() {});
  }

  @override
  void initState() {
    getheDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Reviews", style: AppWidget.blackcolorboldFeildStyle()),
                  SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(height: 50, child: shopList()),
              SizedBox(
                height: 90.0,
              ),
            ],
          )),
    );
  }
}
