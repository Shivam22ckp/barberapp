import 'dart:io';

import 'package:barberstar/barder_app_screen/barber_home.dart';
import 'package:barberstar/barder_app_screen/create_scanner.dart';
import 'package:barberstar/service/database.dart';
import 'package:barberstar/service/shared_pref.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddDetail extends StatefulWidget {
  String shopid,
      adddress,
      cover,
      desc,
      email,
      userid,
      scanner,
      lock,
      phone,
      price,
      shop;
  double latitude, longitude;
  bool edit;
  AddDetail(
      {required this.shopid,
      required this.adddress,
      required this.cover,
      required this.desc,
      required this.scanner,
      required this.edit,
      required this.email,
      required this.latitude,
      required this.lock,
      required this.userid,
      required this.longitude,
      required this.phone,
      required this.price,
      required this.shop});
  @override
  State<AddDetail> createState() => _AddDetailState();
}

class _AddDetailState extends State<AddDetail> {
  String id = "", email = "", image = "";
  getMyInfofromsharedpreference() async {
    id = (await SharedPreferenceHelper().getUserId())!;
    email = (await SharedPreferenceHelper().getUserEmail())!;
    print(id);
    setState(() {});
  }

  getonLoad() async {
    await getMyInfofromsharedpreference();
    setState(() {});
  }

  @override
  void initState() {
    getonLoad();
    image = widget.cover;
    userShopnamecontroller.text = widget.shop;
    userAddresscontroller.text = widget.adddress;
    userPhonecontroller.text = widget.phone;
    userPricecontroller.text = widget.price;
    userdescriptioncontroller.text = widget.desc;

    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  TextEditingController userShopnamecontroller = new TextEditingController();
  TextEditingController userAddresscontroller = new TextEditingController();
  TextEditingController userPhonecontroller = new TextEditingController();
  TextEditingController userPricecontroller = new TextEditingController();
  TextEditingController userdescriptioncontroller = new TextEditingController();
  File? selectedImage;

  addShop() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageref =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);

      final UploadTask task = firebaseStorageref.putFile(selectedImage!);

      var downloadurl = await (await task).ref.getDownloadURL();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CreateScanner(
                    id: id,
                    desc: userdescriptioncontroller.text,
                    phone: userPhonecontroller.text,
                    pic: downloadurl,
                    address: userAddresscontroller.text,
                    shop: userShopnamecontroller.text,
                    price: userPricecontroller.text,
                    email: email,
                    shopid: widget.shopid,
                    edit: widget.edit,
                    scanner: '',
                    latitude: 0.0,
                    longitude: 0.0,
                  )));
    }
    setState(() {});
  }

  Future getImage() async {
    ImagePicker imagePicker;
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(133, 60, 8, 8),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Let's add your Shop",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              widget.edit
                  ? Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(color: Colors.white)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: widget.edit
                            ? Image.network(image, fit: BoxFit.fill)
                            : Image.file(selectedImage!, fit: BoxFit.fill),
                      ))
                  : selectedImage != null
                      ? Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              border: Border.all(color: Colors.white)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: widget.edit
                                ? Image.network(image, fit: BoxFit.fill)
                                : Image.file(selectedImage!, fit: BoxFit.fill),
                          ))
                      : GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                border: Border.all(color: Colors.white)),
                            child: Center(
                                child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            )),
                          ),
                        ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70, width: 2.0),
                    borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  controller: userShopnamecontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Shop Name",
                      hintStyle: AppWidget.lightTextFeildStyle(),
                      prefixIcon: Icon(
                        Icons.shop,
                        color: Colors.white70,
                        size: 30.0,
                      ),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70, width: 2.0),
                    borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  controller: userAddresscontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Address",
                      hintStyle: AppWidget.lightTextFeildStyle(),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white70,
                        size: 30.0,
                      ),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70, width: 2.0),
                    borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  controller: userPhonecontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Phone no.",
                      hintStyle: AppWidget.lightTextFeildStyle(),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.white70,
                        size: 30.0,
                      ),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70, width: 2.0),
                    borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  controller: userPricecontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Starting Price",
                      hintStyle: AppWidget.lightTextFeildStyle(),
                      prefixIcon: Icon(
                        Icons.monetization_on,
                        color: Colors.white70,
                        size: 30.0,
                      ),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 180,
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70, width: 2.0),
                    borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  controller: userdescriptioncontroller,
                  maxLines: 10,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: AppWidget.lightTextFeildStyle(),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  widget.edit
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateScanner(
                                    id: widget.userid,
                                    desc: userdescriptioncontroller.text,
                                    phone: userPhonecontroller.text,
                                    pic: image,
                                    address: userAddresscontroller.text,
                                    shop: userShopnamecontroller.text,
                                    price: userPricecontroller.text,
                                    email: email,
                                    shopid: widget.shopid,
                                    scanner: widget.scanner,
                                    edit: widget.edit,
                                    latitude: widget.latitude,
                                    longitude: widget.longitude,
                                  )))
                      : addShop();
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: AppWidget.createButton("Add")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
