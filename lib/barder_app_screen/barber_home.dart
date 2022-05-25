import 'package:barberstar/barder_app_screen/shop_detail.dart';
import 'package:barberstar/screen/profile.dart';
import 'package:barberstar/service/database.dart';
import 'package:barberstar/service/shared_pref.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class BarberHome extends StatefulWidget {
  @override
  State<BarberHome> createState() => _BarberHomeState();
}

class _BarberHomeState extends State<BarberHome> {
  late Stream shopStream;

  Widget shopList() {
    return StreamBuilder(
        stream: shopStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopDetail(
                                      address: ds["Address"],
                                      desc: ds["Desc"],
                                      image: ds["Cover"],
                                      phone: ds["Phone"],
                                      shop: ds["Shop"],
                                      shopid: ds["Id"],
                                      price: ds["Price"],
                                      barcode: ds["Barcode"],
                                    )));
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 240,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  ds["Cover"],
                                  fit: BoxFit.fill,
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.only(
                                top: 130, left: 10.0, right: 10.0),
                            height: 105,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                // color: Colors.black45,
                                gradient: LinearGradient(
                                    colors: [Colors.black, Colors.black12],
                                    begin: Alignment.bottomCenter,
                                    end: AlignmentDirectional.topCenter),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ds["Shop"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 27.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          ds["Address"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color:
                                              Color.fromARGB(255, 184, 166, 6),
                                          size: 25.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color:
                                              Color.fromARGB(255, 184, 166, 6),
                                          size: 25.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color:
                                              Color.fromARGB(255, 184, 166, 6),
                                          size: 25.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 25.0,
                                          color:
                                              Color.fromARGB(255, 184, 166, 6),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 25.0,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "(3 Reviews)",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Start from",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text("\$" + ds["Price"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  String? name, id;

  getMyInfofromsharedpreference() async {
    name = await SharedPreferenceHelper().getDisplayName();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  getheDetail() async {
    await getMyInfofromsharedpreference();
    shopStream = await DatabaseMethods().getUserShops(id!);

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
      body: name == ""
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, " + name! + "!",
                            style: TextStyle(
                                color: Colors.grey[300],
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Welcome to Your Shops",
                            style: TextStyle(
                                color: Colors.grey[300], fontSize: 16.0),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[300],
                          size: 32,
                        ),
                      )
                    ],
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height,
                      child: shopList())
                ],
              ),
            ),
    );
  }
}
