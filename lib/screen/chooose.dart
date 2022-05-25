import 'package:barberstar/screen/create.dart';
import 'package:barberstar/screen/login.dart';
import 'package:barberstar/service/auth.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:flutter/material.dart';

class Choose extends StatefulWidget {
  Choose({Key? key}) : super(key: key);

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(133, 60, 8, 8),
        body: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                Image.asset(
                  "images/barber1.png",
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        "Welcome to  ",
                        style: AppWidget.boldTextFeildStyle(),
                      ),
                      Text(
                        "Barber Stars,",
                        style: TextStyle(
                          color: Color.fromARGB(
                            255,
                            184,
                            166,
                            6,
                          ),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        "want to find a haircut, now it's easy to register and search for the haircut of your choice",
                        style: AppWidget.lightTextFeildStyle())),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        width: 170,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(
                              255,
                              184,
                              166,
                              6,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          "LOGIN",
                          style: AppWidget.boldTextFeildStyle(),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccount()));
                      },
                      child: Container(
                        width: 170,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(
                              255,
                              184,
                              166,
                              6,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          "REGISTER",
                          style: AppWidget.boldTextFeildStyle(),
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ));
  }
}
