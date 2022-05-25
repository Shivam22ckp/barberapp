import 'package:barberstar/admin/home_admin.dart';
import 'package:barberstar/screen/login.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginAdmin extends StatefulWidget {
  LoginAdmin({Key? key}) : super(key: key);

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(133, 60, 8, 8),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 90.0,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Admin Panel",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70, width: 2.0),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        controller: usernamecontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: AppWidget.lightTextFeildStyle(),
                            prefixIcon: Icon(
                              Icons.email,
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
                        controller: passwordcontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: AppWidget.lightTextFeildStyle(),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white70,
                              size: 30.0,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 70.0,
              ),
              GestureDetector(
                  onTap: () {
                    LoginAdmin();
                  },
                  child: AppWidget.createButton("Login")),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != usernamecontroller.text.trim()) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Your id is not correct")));
        } else if (result.data()['password'] !=
            passwordcontroller.text.trim()) {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Your password is not correct")));
        } else {
          Route route = MaterialPageRoute(builder: (context) => HomeAdmin());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
