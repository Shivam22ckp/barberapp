import 'package:barberstar/barder_app_screen/Add_detail.dart';
import 'package:barberstar/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RemoveBarber extends StatefulWidget {
  RemoveBarber({Key? key}) : super(key: key);

  @override
  State<RemoveBarber> createState() => _RemoveBarberState();
}

class _RemoveBarberState extends State<RemoveBarber> {
  Stream? shopStream;
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
                      onTap: () {},
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 30.0, left: 20.0, right: 10.0),
                            height: 210,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  ds["Cover"],
                                  fit: BoxFit.fill,
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 30.0, top: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddDetail(
                                              shopid: ds["Id"],
                                              edit: true,
                                              adddress: ds["Address"],
                                              cover: ds["Cover"],
                                              desc: ds["Desc"],
                                              email: ds["Email"],
                                              latitude: ds["Latitude"],
                                              longitude: ds["Longitude"],
                                              phone: ds["Phone"],
                                              price: ds["Price"],
                                              shop: ds["Shop"],
                                              userid: ds["userid"],
                                              lock: '',
                                              scanner: ds["Barcode"],
                                            )));
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.only(
                                top: 100, left: 20.0, right: 20.0),
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
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await FirebaseFirestore.instance
                                            .runTransaction((Transaction
                                                myTransaction) async {
                                          await myTransaction.delete(snapshot
                                              .data.docs[index].reference);
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Remove Shop",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )
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
                                )
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

  getheDetail() async {
    shopStream = await DatabaseMethods().getLocatedShops();
    setState(() {});
  }

  onload() async {
    await getheDetail();
  }

  @override
  void initState() {
    onload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Remove Shop"),
        elevation: 0.0,
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: shopList(),
    );
  }
}
