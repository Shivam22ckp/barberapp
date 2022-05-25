import 'dart:io';

import 'package:barberstar/service/database.dart';
import 'package:barberstar/service/shared_pref.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class GalleryPart extends StatefulWidget {
  String shopid;

  GalleryPart({required this.shopid});

  @override
  State<GalleryPart> createState() => _GalleryPartState();
}

class _GalleryPartState extends State<GalleryPart> {
  late File selectedImage;
  final ImagePicker _picker = ImagePicker();

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

  addShop() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageref =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);

      final UploadTask task = firebaseStorageref.putFile(selectedImage);

      var downloadurl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> AddShopInfo = {
        "Photo": downloadurl,
      };
      DatabaseMethods().addShopGallery(AddShopInfo, widget.shopid);
      print(id);
      DatabaseMethods().addUserShopGallery(AddShopInfo, id!, widget.shopid);

      setState(() {});
    }
  }

  Future getImage() async {
    ImagePicker imagePicker;
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(image.path);
    });
    addShop();
  }

  bool review = false, gallery = false, detail = true;
  String? id, email;
  getMyInfofromsharedpreference() async {
    email = await SharedPreferenceHelper().getUserEmail();
    id = await SharedPreferenceHelper().getUserId();
  }

  getheDetail() async {
    await getMyInfofromsharedpreference();
    gallerystream =
        await DatabaseMethods().getOwnerShopGallery(id!, widget.shopid);
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
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
                width: 140,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 184, 166, 6),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Add Photos",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
