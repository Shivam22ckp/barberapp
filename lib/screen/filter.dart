import 'package:barberstar/screen/home.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:flutter/material.dart';

class FilterCopy extends StatefulWidget {
  double distance;
  String price;
  FilterCopy({required this.distance, required this.price});
  @override
  State<FilterCopy> createState() => _FilterCopyState();
}

class _FilterCopyState extends State<FilterCopy> {
  RangeValues values = RangeValues(50, 100);
  double value = 5;

  @override
  void initState() {
    value = widget.distance;
    values = RangeValues(50, double.parse(widget.price));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(color: Colors.black),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                ),
                Text(
                  "Filter",
                  style: AppWidget.blackcolorboldFeildStyle(),
                ),
                SizedBox(
                  width: 100,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Colors.grey[300],
                    size: 25.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Price Range",
            style: AppWidget.blackcolorboldFeildStyle(),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: RangeSlider(
              inactiveColor: Colors.grey,
              activeColor: Colors.black,
              min: 50,
              max: 300,
              divisions: 20,
              labels: RangeLabels(values.start.round().toString(),
                  values.end.round().toString()),
              values: values,
              onChanged: (values) => setState(() {
                this.values = values;
              }),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Distance (Km)",
            style: AppWidget.blackcolorboldFeildStyle(),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Slider(
              inactiveColor: Colors.grey,
              activeColor: Colors.black,
              min: 1,
              max: 50,
              divisions: 20,
              label: value.round().toString(),
              value: value,
              onChanged: (value) => setState(() {
                this.value = value;
              }),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(
                            distancefilter: value,
                            pricefilter: values.end.round().toString(),
                          )));
            },
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(18)),
              child: Text(
                "Apply Filter",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
