import 'package:barberstar/service/database.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BarberGallery extends StatefulWidget {
  String id;
  BarberGallery({required this.id});

  @override
  State<BarberGallery> createState() => _BarberGalleryState();
}

class _BarberGalleryState extends State<BarberGallery> {
  late Stream gallerystream;

  Widget galleryList() {
    return StreamBuilder(
        stream: gallerystream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? PageView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            ds["Photo"],
                            fit: BoxFit.fill,
                          )),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  getheDetail() async {
    gallerystream = await DatabaseMethods().getShopsGallery(widget.id);
    setState(() {});
  }

  @override
  void initState() {
    getheDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Gallery", style: AppWidget.blackcolorboldFeildStyle()),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(height: 250, child: galleryList()),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
