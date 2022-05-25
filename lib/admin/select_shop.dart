import 'package:barberstar/barder_app_screen/Add_detail.dart';
import 'package:barberstar/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectShop extends StatefulWidget {
  SelectShop({Key? key}) : super(key: key);

  @override
  State<SelectShop> createState() => _SelectShopState();
}

class _SelectShopState extends State<SelectShop> {
  late Stream userStream;

  Widget seeUser() {
    return StreamBuilder(
      stream: userStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddDetail(
                                  shopid: "",
                                  adddress: "",
                                  cover: "",
                                  desc: "",
                                  scanner: "",
                                  edit: false,
                                  email: "",
                                  latitude: 0.0,
                                  lock: "",
                                  userid: ds["Id"],
                                  longitude: 0.0,
                                  phone: "",
                                  price: "",
                                  shop: "")));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      padding: EdgeInsets.only(left: 10, top: 10),
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 210,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(ds["Images"], height: 120, width: 120),
                          Text(
                            ds['Name'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            ds['Email'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    doonthisLaunc();
  }

  getAdminUsers() async {
    userStream = await DatabaseMethods().getUserAdmin();
    setState(() {});
  }

  doonthisLaunc() {
    getAdminUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Select the User"),
        elevation: 0.0,
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: seeUser(),
    );
  }
}
