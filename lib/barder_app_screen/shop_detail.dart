import 'dart:io';

import 'package:barberstar/barder_app_screen/barber_own_review.dart';
import 'package:barberstar/barder_app_screen/gallery.dart';
import 'package:barberstar/barder_app_screen/showbarcode.dart';
import 'package:barberstar/service/database.dart';
import 'package:barberstar/service/shared_pref.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import 'barber_home.dart';

class ShopDetail extends StatefulWidget {
  String image, address, desc, phone, shop, shopid, price, barcode;
  ShopDetail(
      {required this.address,
      required this.desc,
      required this.image,
      required this.phone,
      required this.shop,
      required this.shopid,
      required this.price,
      required this.barcode});

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  late File selectedImage;
  final ImagePicker _picker = ImagePicker();

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
      DatabaseMethods()
          .addShopGallery(AddShopInfo, widget.shopid)
          .then((value) {
        DatabaseMethods().addAddShopDetail(AddShopInfo, id!, widget.shopid);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BarberHome()));
      });
      setState(() {});
    }
  }

  Future getImage() async {
    ImagePicker imagePicker;
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(image.path);
    });
  }

  bool review = false, gallery = false, detail = true;
  String? id, email;
  getMyInfofromsharedpreference() async {
    email = await SharedPreferenceHelper().getUserEmail();
    id = await SharedPreferenceHelper().getUserId();
  }

  getheDetail() async {
    await getMyInfofromsharedpreference();

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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(children: [
              Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.fill,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BarberHome()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 28.0,
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => AddDetail(
                  //               image:  widget.image,
                  //               desc: widget.desc,
                  //               address: widget.address,
                  //               name: widget.shop,
                  //               phone: widget.phone,
                  //               price: widget.price,
                  //             )));
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Icon(
                  //       Icons.edit,
                  //       color: Colors.white,
                  //       size: 28.0,
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ]),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.shop,
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShowBarcode(barcode: widget.barcode)));
                  },
                  child: Icon(
                    Icons.qr_code_scanner_outlined,
                    size: 35.0,
                    color: Colors.grey[300],
                  ),
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
                  color: Color.fromARGB(255, 184, 166, 6),
                  size: 25.0,
                ),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 184, 166, 6),
                  size: 25.0,
                ),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 184, 166, 6),
                  size: 25.0,
                ),
                Icon(
                  Icons.star,
                  size: 25.0,
                  color: Colors.grey,
                ),
                Icon(
                  Icons.star,
                  size: 25.0,
                  color: Colors.grey,
                ),
                Text(
                  "(" + "0" + " Reviews)",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 55,
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        review = false;
                        gallery = false;
                        detail = true;
                        setState(() {});
                      },
                      child: detail
                          ? AppWidget.shortButton("Detail")
                          : AppWidget.createColortext("Details")),
                  GestureDetector(
                      onTap: () {
                        review = true;
                        gallery = false;
                        detail = false;
                        setState(() {});
                      },
                      child: review
                          ? AppWidget.shortButton("Reviews")
                          : AppWidget.createColortext("Reviews")),
                  GestureDetector(
                      onTap: () {
                        review = false;
                        gallery = true;
                        detail = false;
                        setState(() {});
                      },
                      child: gallery
                          ? AppWidget.shortButton("Gallery")
                          : AppWidget.createColortext("Gallery")),
                ],
              ),
            ),
            detail
                ? Detailspage(
                    desc: widget.desc,
                    email: email!,
                    address: widget.address,
                    phone: widget.phone,
                  )
                : Container(),
            review
                ? Container(
                    height: 200, child: OwnReview(shopid: widget.shopid))
                : Container(),
            gallery
                ? GalleryPart(
                    shopid: widget.shopid,
                  )
                : Container(),
          ]),
        ),
      ),
    );
  }
}

class Detailspage extends StatelessWidget {
  String desc, email, address, phone;
  Detailspage(
      {required this.address,
      required this.desc,
      required this.email,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Description",
          style: AppWidget.blackcolorboldFeildStyle(),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          desc,
          style: TextStyle(color: Colors.grey[300]),
        ),
        SizedBox(
          height: 10.0,
        ),
        Divider(
          color: Colors.grey[300],
        ),
        Row(
          children: [
            Text(
              "Contact ",
              style: AppWidget.blackcolorboldFeildStyle(),
            ),
            Text(
              "details",
              style: TextStyle(color: Colors.grey[300], fontSize: 20.0),
            )
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            Icon(
              Icons.email_outlined,
              color: Colors.grey[300],
              size: 25.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              email,
              style: TextStyle(color: Colors.grey[300], fontSize: 18.0),
            )
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.grey[300],
              size: 25.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              address,
              style: TextStyle(color: Colors.grey[300], fontSize: 18.0),
            )
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            Icon(
              Icons.phone,
              color: Colors.grey[300],
              size: 25.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              phone,
              style: TextStyle(color: Colors.grey[300], fontSize: 18.0),
            )
          ],
        )
      ],
    ));
  }
}
