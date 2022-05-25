import 'package:barberstar/barder_app_screen/Add_detail.dart';
import 'package:barberstar/screen/chooose.dart';
import 'package:barberstar/screen/home.dart';
import 'package:barberstar/screen/rate.dart';
import 'package:barberstar/service/database.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BarberReview extends StatefulWidget {
  String? reviewnumber, userid, shopid, username, userimage;
  BarberReview(
      {this.reviewnumber,
      this.shopid,
      this.userid,
      this.username,
      this.userimage});

  @override
  State<BarberReview> createState() => _BarberReviewState();
}

class _BarberReviewState extends State<BarberReview> {
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
                                child: Text(
                                  ds["Review"],
                                  maxLines: 5,
                                  style: TextStyle(color: Colors.grey[300]),
                                ),
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
    reviewStream = await DatabaseMethods().getUserShopsReviews(widget.shopid!);
    setState(() {});
  }

  @override
  void initState() {
    getheDetail();
    super.initState();
  }

  String? scanResult;
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
                    Text("Reviews",
                        style: AppWidget.blackcolorboldFeildStyle()),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(height: 180, child: shopList()),
                SizedBox(
                  height: 90.0,
                ),
                GestureDetector(
                  onTap: () {
                    scanBarcode(context);
                  },
                  child: Container(
                      width: 140,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Add Review",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            )));
  }

  Future scanBarcode(context) async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      scanResult = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      this.scanResult = scanResult;
      scanResult == widget.reviewnumber
          ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Rate(
                        userid: widget.userid!,
                        shopid: widget.shopid!,
                        userimage: widget.userimage!,
                        username: widget.username!,
                      )))
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => Choose()));
    });
  }
}
