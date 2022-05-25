import 'package:barberstar/admin/login_admin.dart';
import 'package:barberstar/screen/bottomnav.dart';
import 'package:barberstar/screen/create.dart';
import 'package:barberstar/screen/forgot_password.dart';
import 'package:barberstar/screen/home.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "", password = "";

  final _formkey = GlobalKey<FormState>();
  TextEditingController useremaileditingcontroller =
      new TextEditingController();
  TextEditingController userpasswordeditingcontroller =
      new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Bottomnav(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(133, 60, 8, 8),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Text(
                "Hello",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Text("Sign in to your ",
                      style: AppWidget.lightTextFeildStyle()),
                  Text(
                    "account!",
                    style: TextStyle(
                        color: Color.fromARGB(255, 184, 166, 6),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 40.0,
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
                        controller: useremaileditingcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          } else if (!value.contains('@')) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Email",
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        controller: userpasswordeditingcontroller,
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
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                },
                child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text("Forgot Password?",
                        style: AppWidget.lightTextFeildStyle())),
              ),
              SizedBox(
                height: 60.0,
              ),
              GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = useremaileditingcontroller.text;
                        password = userpasswordeditingcontroller.text;
                      });
                      userLogin();
                    }
                  },
                  child: AppWidget.createButton("Sign in")),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppWidget.lightTextFeildStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAccount()));
                    },
                    child: Text("Create",
                        style: TextStyle(
                          color: Color.fromARGB(255, 184, 166, 6),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginAdmin()));
                },
                child: Center(
                  child: Text(
                    "Admin Panel",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
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
