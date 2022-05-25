import 'package:barberstar/admin/home_admin.dart';
import 'package:barberstar/admin/login_admin.dart';
import 'package:barberstar/barder_app_screen/Add_detail.dart';
import 'package:barberstar/barder_app_screen/barber_home.dart';
import 'package:barberstar/barder_app_screen/create_scanner.dart';
import 'package:barberstar/screen/bottomnav.dart';
import 'package:barberstar/screen/chooose.dart';
import 'package:barberstar/screen/create.dart';
import 'package:barberstar/screen/home.dart';
import 'package:barberstar/screen/login.dart';
import 'package:barberstar/screen/rate.dart';
import 'package:barberstar/service/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: AuthMethods().getCurrentUser(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Bottomnav();
            } else {
              return Choose();
            }
          },
        ));
  }
}
