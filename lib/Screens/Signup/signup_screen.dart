import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterbidapp/components/rounded_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  final String type;
  final User user;

  SignUpScreen({this.type, this.user});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _globalkey = GlobalKey<FormState>();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget profileimage() {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 82.0,
          backgroundColor: Colors.grey[400],//Color(0xffFDCF09),
          child: CircleAvatar(
            radius: 80.0,
            backgroundColor: Colors.grey[50],
            backgroundImage: _imageFile == null
                ? AssetImage("assets/images/diamond.png")
                : FileImage(File(_imageFile.path)),
          ),
        ),
        Positioned(
            bottom: 0.0,
            right: 0.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: Icon(
                Icons.camera_alt,
                size: 40.0,

              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.deepOrangeAccent,
          ),
        ),
        body:
        Form(
          key: _globalkey,
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    profileimage(),
                    SizedBox(height: 30.0,),
                    Container(
                      width: size.width*0.85,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(90.0)),
                              borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: "WorkSansLight"),
                          filled: true,
                          fillColor: Colors.grey[400],
                          hintText: 'First Name',
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0,),
                    Container(
                      width: size.width*0.85,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(90.0)),
                              borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: "WorkSansLight"),
                          filled: true,
                          fillColor: Colors.grey[400],
                          hintText: 'Last Name',
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0,),
                    Container(
                      width: size.width*0.85,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.place,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(90.0)),
                                    borderSide: BorderSide.none),
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "WorkSansLight"),
                                filled: true,
                                fillColor: Colors.grey[400],
                                hintText: 'Location',
                              ),
                              enabled: false,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              onPressed: (){},
                              child: Icon(
                                Icons.add_location,
                                size: 36.0,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  width: size.width*0.85,
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: RoundedButton(
                    text: "REGISTER",
                    radius: 90.0,
                    press: (){},
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.grey[50],
                  ),
                ),

              ],
            ),
          ),
        ),
        );
  }
}
