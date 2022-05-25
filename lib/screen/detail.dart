import 'package:barberstar/screen/barber_gallery.dart';
import 'package:barberstar/screen/barber_review.dart';
import 'package:barberstar/screen/create.dart';
import 'package:barberstar/screen/home.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Detail extends StatefulWidget {
  String? image,
      name,
      desc,
      phone,
      email,
      address,
      reviewnumber,
      userid,
      shopid,
      userimage,
      username;
  Detail(
      {this.image,
      this.name,
      this.address,
      this.desc,
      this.email,
      this.phone,
      this.reviewnumber,
      this.shopid,
      this.userid,
      this.userimage,
      this.username});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool review = false, gallery = false, detail = true;
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
                      widget.image!,
                      fit: BoxFit.fill,
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(
                                distancefilter: 8.0,
                                pricefilter: "250",
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
              )
            ]),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.name!,
              style: TextStyle(
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
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
                  "(" + "3" + " Reviews)",
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
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
                    email: widget.email,
                    address: widget.address,
                    phone: widget.phone,
                    desc: widget.desc,
                  )
                : Container(),
            review
                ? Container(
                    height: 400,
                    child: BarberReview(
                      reviewnumber: widget.reviewnumber!,
                      userid: widget.userid!,
                      shopid: widget.shopid!,
                      username: widget.username!,
                      userimage: widget.userimage!,
                    ),
                  )
                : Container(),
            gallery ? BarberGallery(id: widget.shopid!) : Container(),
          ]),
        ),
      ),
    );
  }
}

class Detailspage extends StatelessWidget {
  String? desc, phone, email, address;
  Detailspage(
      {required this.desc,
      required this.email,
      required this.phone,
      required this.address});

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
          desc!,
          style: TextStyle(color: Colors.grey[300]),
        ),
        SizedBox(
          height: 10.0,
        ),
        Divider(
          color: Colors.grey,
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
              email!,
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
              address!,
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
              phone!,
              style: TextStyle(color: Colors.grey[300], fontSize: 18.0),
            )
          ],
        )
      ],
    ));
  }
}
