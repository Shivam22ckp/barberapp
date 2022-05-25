import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ShowBarcode extends StatefulWidget {
  String barcode;
  ShowBarcode({required this.barcode});

  @override
  State<ShowBarcode> createState() => _ShowBarcodeState();
}

class _ShowBarcodeState extends State<ShowBarcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(133, 60, 8, 8),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          children: [
            Text(
              "Scan the Barcode to add the Review.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 80.0,
            ),
            Center(
              child: Card(
                color: Colors.white,
                elevation: 6.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: widget.barcode,
                    width: 200,
                    height: 200,
                    drawText: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
