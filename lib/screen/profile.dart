import 'dart:io';

import 'package:barberstar/screen/chooose.dart';
import 'package:barberstar/service/database.dart';
import 'package:barberstar/service/shared_pref.dart';
import 'package:barberstar/widgets/support_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _picker = ImagePicker();
  String name = "", id = "", pic = "", email = "", getid = "";
  File? selectedImage;

  updateprofile() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageref =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);

      final UploadTask task = firebaseStorageref.putFile(selectedImage!);

      var downloadurl = await (await task).ref.getDownloadURL();
      SharedPreferenceHelper().saveUserProfileUrl(downloadurl);

      Map<String, dynamic> updateuserInfo = {
        "Name": name,
        "Id": id,
        "Email": email,
        "Images": downloadurl,
      };
      DatabaseMethods().updateProfile(id, updateuserInfo);
      setState(() {});
    }
  }

  Future getImage() async {
    ImagePicker imagePicker;
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(image.path);
    });
    updateprofile();
  }

  getMyInfofromsharedpreference() async {
    id = (await SharedPreferenceHelper().getUserId())!;
    print(id);
  }

  getThisUserinfo() async {
    await getMyInfofromsharedpreference();

    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(id);

    name = "${querySnapshot.docs[0]["Name"]}";
    getid = "${querySnapshot.docs[0].id}";
    email = "${querySnapshot.docs[0]["Email"]}";
    pic = "${querySnapshot.docs[0]["Images"]}";
    setState(() {});
  }

  @override
  void initState() {
    getThisUserinfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Profile",
            style: TextStyle(
                color: Colors.grey[300],
                fontWeight: FontWeight.bold,
                fontSize: 25.0)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: pic == ""
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  selectedImage != null
                      ? Center(
                          child: GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Container(
                              height: 170,
                              width: 170,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            height: 170,
                            width: 170,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Image.network(
                                pic,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey[300],
                        size: 30.0,
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name",
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 17.0)),
                          Text(name,
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 20.0))
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 30.0,
                        color: Colors.grey[300],
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 17.0)),
                          Text(email,
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 20.0))
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Choose()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(13),
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Text(
                        "Log Out",
                        style: TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
