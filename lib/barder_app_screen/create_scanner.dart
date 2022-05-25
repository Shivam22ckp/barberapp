import 'package:barberstar/admin/home_admin.dart';
import 'package:barberstar/barder_app_screen/barber_home.dart';
import 'package:barberstar/service/database.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:random_string/random_string.dart';

class CreateScanner extends StatefulWidget {
  String id, shop, address, phone, price, pic, desc, email, shopid, scanner;
  double latitude, longitude;

  bool edit;
  CreateScanner(
      {required this.id,
      required this.address,
      required this.pic,
      required this.desc,
      required this.phone,
      required this.price,
      required this.shop,
      required this.email,
      required this.shopid,
      required this.scanner,
      required this.edit,
      required this.latitude,
      required this.longitude});

  @override
  State<CreateScanner> createState() => _CreateScannerState();
}

class _CreateScannerState extends State<CreateScanner> {
  Position? _currentUserLocation;
  @override
  void initState() {
    getoncecurrentlocation();
    barcodecontroller.text = widget.scanner;
    super.initState();
  }

  getoncecurrentlocation() async {
    _currentUserLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  TextEditingController barcodecontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(133, 60, 8, 8),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 90.0),
          child: Column(
            children: [
              Text(
                "Add the Barcode to add the review",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40.0,
              ),
              Card(
                color: Colors.white,
                elevation: 6.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: barcodecontroller.text,
                    width: 200,
                    height: 200,
                    drawText: false,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.white)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: barcodecontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              String key =
                                  widget.shop.substring(0, 1).toUpperCase();
                              String addId = randomAlphaNumeric(10);
                              Map<String, dynamic> AddShopInfo = {
                                "Shop": widget.shop,
                                "Id": widget.edit ? widget.shopid : addId,
                                "Address": widget.address,
                                "Phone": widget.phone,
                                "Price": widget.price,
                                "Cover": widget.pic,
                                "Desc": widget.desc,
                                "Barcode": barcodecontroller.text,
                                "Latitude": widget.edit
                                    ? widget.latitude
                                    : _currentUserLocation!.latitude,
                                "Longitude": widget.edit
                                    ? widget.longitude
                                    : _currentUserLocation!.longitude,
                                "Email": widget.email,
                                "Key": key,
                                "userid": widget.id,
                              };
                              widget.edit
                                  ? DatabaseMethods().updateshopdetail(
                                      widget.shopid, AddShopInfo)
                                  : DatabaseMethods()
                                      .addShopDetail(AddShopInfo, addId)
                                      .then((value) {
                                      widget.edit
                                          ? DatabaseMethods()
                                              .updateaddshopdetail(AddShopInfo,
                                                  widget.id, widget.shopid)
                                          : DatabaseMethods().addAddShopDetail(
                                              AddShopInfo, widget.id, addId);
                                      Fluttertoast.showToast(
                                          msg: widget.edit
                                              ? "Shop Updated Successfully!!"
                                              : "Shop Added Successfully!!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeAdmin()));
                                    });
                            },
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                            ))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
