import 'package:barberstar/barder_app_screen/Add_detail.dart';
import 'package:barberstar/barder_app_screen/barber_home.dart';
import 'package:barberstar/barder_app_screen/barberbottomnav.dart';
import 'package:barberstar/screen/bottomnav.dart';
import 'package:barberstar/screen/home.dart';
import 'package:barberstar/screen/login.dart';
import 'package:barberstar/service/database.dart';
import 'package:barberstar/service/shared_pref.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool shop = false, costumer = true;
  String email = "", password = "";
  String message = "";

  TextEditingController useremaileditingController =
      new TextEditingController();
  TextEditingController usernameeditingController = new TextEditingController();
  TextEditingController userpasswordeditingController =
      new TextEditingController();
  registration() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Registered Successfully.",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );
      costumer
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Bottomnav(),
              ),
            )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Barber_Bottomnav(),
              ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("Password Provided is too Weak");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Password Provided is too Weak",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        print("Account Already exists");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Account Already exists",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  final _formkey = GlobalKey<FormState>();
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
                  "Create account",
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
                        controller: usernameeditingController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: AppWidget.lightTextFeildStyle(),
                            prefixIcon: Icon(
                              Icons.person,
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
                        controller: useremaileditingController,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          } else if (!value.contains('@')) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
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
                        controller: userpasswordeditingController,
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
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    shop
                        ? Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 184, 166, 6),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Shop Owner",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ))
                        : GestureDetector(
                            onTap: () {
                              shop = true;
                              costumer = false;
                              setState(() {});
                            },
                            child: Text(
                              "Shop Owner",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            )),
                    costumer
                        ? Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 184, 166, 6),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Costumer",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ))
                        : GestureDetector(
                            onTap: () {
                              shop = false;
                              costumer = true;
                              setState(() {});
                            },
                            child: Text(
                              "Costumer",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            )),
                  ],
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = useremaileditingController.text;
                        password = userpasswordeditingController.text;
                      });
                      if (message == "") {
                        message = randomAlphaNumeric(10);
                        SharedPreferenceHelper()
                            .saveDisplayName(usernameeditingController.text);
                        SharedPreferenceHelper()
                            .saveUserEmail(useremaileditingController.text);
                        SharedPreferenceHelper().saveUserId(message);
                        SharedPreferenceHelper().saveUserProfileUrl(
                            "https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc1.appspot.com/o/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b4a0-676fbc75b34a");

                        Map<String, dynamic> userInfoMap = {
                          "Name": usernameeditingController.text,
                          "Email": useremaileditingController.text,
                          "Id": message,
                          "Images":
                              "https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc1.appspot.com/o/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b4a0-676fbc75b34a"
                        };
                        DatabaseMethods().addUserDetail(userInfoMap, message);
                      }
                      registration();
                    }
                  },
                  child: AppWidget.createButton("Create")),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: AppWidget.lightTextFeildStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text("Log in",
                        style: TextStyle(
                          color: Color.fromARGB(255, 184, 166, 6),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
