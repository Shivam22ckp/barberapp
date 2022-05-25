import 'package:barberstar/screen/home.dart';
import 'package:barberstar/screen/profile.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class Bottomnav extends StatefulWidget {
  Bottomnav({Key? key}) : super(key: key);

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int currentTabIndex = 0;
  late List<Widget> pages;

  late Widget currentPage;

  late Home home;

  late Profile profile;

  @override
  void initState() {
    profile = Profile();
    home = Home(
      distancefilter: 5.0,
      pricefilter: "100",
    );
    pages = [home, profile];
    currentPage = home;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.black,
        animationDuration: Duration(microseconds: 1000),
        selectedIndex: currentTabIndex,
        onItemSelected: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            title: Text(
              "Home",
              style: TextStyle(color: Colors.grey),
            ),
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person, color: Colors.grey),
            title: Text("Profile", style: TextStyle(color: Colors.grey)),
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
