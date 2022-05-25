import 'dart:ui';

import 'package:barberstar/screen/detail.dart';
import 'package:barberstar/screen/filter.dart';
import 'package:barberstar/screen/profile.dart';
import 'package:barberstar/service/database.dart';
import 'package:barberstar/service/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  double distancefilter;
  String pricefilter;
  Home({required this.distancefilter, required this.pricefilter});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController userserachcontroller = new TextEditingController();

  Stream? shopStream;
  double distance = 5.0;
  var distanceImMeter;
  Position? _currentUserLocation;
  String? name, id, image;
  int? finaldistance;
  bool searching = false;

  distanceCovered(double shoplatitude, double shoplongitude) async {
    distanceImMeter = await Geolocator.distanceBetween(
      _currentUserLocation!.latitude,
      _currentUserLocation!.longitude,
      shoplatitude,
      shoplongitude,
    );
    finaldistance = distanceImMeter!.round().toInt();
    distance = finaldistance! / 1000;
    print(_currentUserLocation!.latitude);
    print(distance);
    print(shoplatitude);
  }

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      searching = true;
    });
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      DatabaseMethods().SearchtheBarber(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Shop'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  Widget shopList() {
    return StreamBuilder(
        stream: shopStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    distanceCovered(ds["Latitude"], ds["Longitude"]);

                    return widget.distancefilter >= distance &&
                            int.parse(widget.pricefilter) >=
                                int.parse(ds["Price"])
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detail(
                                            image: ds["Cover"],
                                            name: ds["Shop"],
                                            desc: ds["Desc"],
                                            phone: ds["Phone"],
                                            address: ds["Address"],
                                            email: ds["Email"],
                                            reviewnumber: ds["Barcode"],
                                            userid: id,
                                            shopid: ds["Id"],
                                            username: name,
                                            userimage: image,
                                          )));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20.0),
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
                                          colors: [
                                            Colors.black,
                                            Colors.black12
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: AlignmentDirectional.topCenter),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                Icons.near_me,
                                                color: Colors.white,
                                                size: 27.0,
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                distance.round().toString() +
                                                    "KM Away",
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
                                                color: Color.fromARGB(
                                                    255, 184, 166, 6),
                                                size: 25.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                    255, 184, 166, 6),
                                                size: 25.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                    255, 184, 166, 6),
                                                size: 25.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 25.0,
                                                color: Color.fromARGB(
                                                    255, 184, 166, 6),
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 25.0,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "(3 Reviews)",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Start from",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0),
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
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container();
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  getMyInfofromsharedpreference() async {
    name = (await SharedPreferenceHelper().getDisplayName())!;
    id = await SharedPreferenceHelper().getUserId();
    image = await SharedPreferenceHelper().getUserProfileUrl();
  }

  getheDetail() async {
    await getMyInfofromsharedpreference();
    shopStream = await DatabaseMethods().getLocatedShops();
    setState(() {});
  }

  getoncecurrentlocation() async {
    _currentUserLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void initState() {
    getoncecurrentlocation();
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
            : SingleChildScrollView(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
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
                                  "Let's make your hair attractive",
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
                                color: Colors.grey,
                                size: 32,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            onChanged: (value) {
                              initiateSearch(value);
                            },
                            controller: userserachcontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search_sharp,
                                color: Colors.grey,
                                size: 25.0,
                              ),
                              suffixIcon: Container(
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20))),
                                      context: context,
                                      builder: (context) => FilterCopy(
                                        distance: widget.distancefilter,
                                        price: widget.pricefilter,
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.more_horiz_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        searching
                            ? ListView(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                primary: false,
                                shrinkWrap: true,
                                children: tempSearchStore.map((element) {
                                  return buildResultCard(element);
                                }).toList())
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Saloons ",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      Text(
                                        "near you",
                                        style: TextStyle(
                                            color: Colors.grey[300],
                                            fontSize: 20.0),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: shopList())
                                ],
                              ),
                      ]),
                ),
              ));
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Detail(
                      image: data["Cover"],
                      name: data["Shop"],
                      desc: data["Desc"],
                      phone: data["Phone"],
                      address: data["Address"],
                      email: data["Email"],
                      reviewnumber: data["Barcode"],
                      userid: id,
                      shopid: data["Id"],
                      username: name,
                      userimage: image,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(
                data["Cover"],
                fit: BoxFit.fill,
                height: 60,
                width: 60,
              ),
            ),
            SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                data["Shop"],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
