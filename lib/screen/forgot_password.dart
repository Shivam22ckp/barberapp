
import 'package:barberstar/screen/login.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'create.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  final _formKey = GlobalKey<FormState>();

  var email = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();

  resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          'Password Reset Email has been sent !',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         backgroundColor: Colors.orangeAccent,
    //         content: Text(
    //           'No user found for that email.',
    //           style: TextStyle(fontSize: 18.0),
    //         ),
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(133, 60, 8, 8),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          children: [
            SizedBox(
              height: 70.0,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "Password Recovery",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Enter ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white70, width: 2.0),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          controller: emailController,
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
                      SizedBox(height: 40.0),
                      Container(
                        margin: EdgeInsets.only(left: 60.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    email = emailController.text;
                                  });
                                  resetPassword();
                                }
                              },
                              child: Container(
                                  width: 140,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 184, 166, 6),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "Send Email",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, a, b) => Login(),
                                      transitionDuration: Duration(seconds: 0),
                                    ),
                                    (route) => false);
                              },
                              child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text("LogIn",
                                      style: AppWidget.lightTextFeildStyle())),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50.0,),
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
                      )
                    ],
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
