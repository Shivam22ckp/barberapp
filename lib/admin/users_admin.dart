import 'package:barberstar/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User_Admin extends StatefulWidget {
  User_Admin({Key? key}) : super(key: key);

  @override
  State<User_Admin> createState() => _User_AdminState();
}

class _User_AdminState extends State<User_Admin> {
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
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    padding: EdgeInsets.only(left: 10, top: 10),
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 240,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          ds["Images"],
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
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
                        GestureDetector(
                          onTap: () async {
                            await FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              await myTransaction
                                  .delete(snapshot.data.docs[index].reference);
                            });
                          },
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Remove User",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
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
        title: Text("Current Users"),
        elevation: 0.0,
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: seeUser(),
    );
  }
}
