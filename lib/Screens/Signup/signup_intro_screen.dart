import 'package:flutter/material.dart';
import '../../components/rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signup_screen.dart';
import '../../home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class SignUpIntroScreen extends StatelessWidget {
  final User user;

  SignUpIntroScreen({this.user});

  String _fullName = "";
  String _businessName = "";
  String _email = "";

  void _showSupplierRegistrationForm(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.deepOrangeAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _fullName = "";
                                  _businessName = "";
                                  _email = "";
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "SUPPLIER",
                              ),
                              SizedBox(
                                height: size.height * 0.1,
                              ),
                              TextFormField(
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
                                  fillColor: Colors.white24,
                                  hintText: 'Full Name',
                                ),
                                onChanged: (text) {
                                  _fullName = text;
                                },
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.business,
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
                                    fillColor: Colors.white24,
                                    hintText: 'Business Name'),
                                onChanged: (text) {
                                  _businessName = text;
                                },
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                        // width: 0.0 produces a thin "hairline" border
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        borderSide: BorderSide.none
                                        //borderSide: const BorderSide(),
                                        ),
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "WorkSansLight"),
                                    filled: true,
                                    fillColor: Colors.white24,
                                    hintText: 'Business Email Address'),
                                onChanged: (text) {
                                  _email = text;
                                },
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 50.0),
                      child: RoundedButton(
                        text: "REGISTER",
                        radius: 90.0,
                        press: () async {
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(user.uid)
                              .set({
                            'Email': _email,
                            'Name': _fullName,
                            'Business_Name': _businessName
                          });
                          _fullName = "";
                          _businessName = "";
                          _email = "";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                    //user: user,
                                  )));
                        },
                        color: Colors.white,
                        textColor: Colors.deepOrangeAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showCustomerRegistrationForm(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.deepOrangeAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _fullName = "";
                                  _businessName = "";
                                  _email = "";
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "CUSTOMER",
                              ),
                              SizedBox(
                                height: size.height * 0.1,
                              ),
                              TextFormField(
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
                                    fillColor: Colors.white24,
                                    hintText: 'Full Name'),
                                onChanged: (text) {
                                  _fullName = text;
                                },
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                        // width: 0.0 produces a thin "hairline" border
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        borderSide: BorderSide.none
                                        //borderSide: const BorderSide(),
                                        ),
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "WorkSansLight"),
                                    filled: true,
                                    fillColor: Colors.white24,
                                    hintText: 'Email Address'),
                                onChanged: (text) {
                                  _email = text;
                                },
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 50.0),
                      child: RoundedButton(
                        text: "REGISTER",
                        radius: 90.0,
                        press: () async {
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(user.uid)
                              .set({
                            'Email': _email,
                            'Name': _fullName,
                            'Business_Name': _businessName
                          });
                          _fullName = "";
                          _businessName = "";
                          _email = "";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                    //user: user,
                                  )));
                        },
                        color: Colors.white,
                        textColor: Colors.deepOrangeAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[50],
            iconTheme: IconThemeData(
              color: Colors.deepOrangeAccent,
            ),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "HELLO NEW USER",
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "CONTINUE AS",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              RoundedButton(
                text: "CUSTOMER",
                radius: 20.0,
                press: () {
                  //print("customer");
                  //_showCustomerRegistrationForm(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpScreen(
                              user: user,
                              type: "customer"
                          )));
                },
                color: Colors.deepOrangeAccent,
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                text: "SUPPLIER",
                radius: 20.0,
                color: Colors.deepOrangeAccent,
                press: () {
                  //print("supplier");
                  //_showSupplierRegistrationForm(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpScreen(
                            user: user,
                            type: "supplier"
                          )));
                },
              ),
            ],
          ))),
    );
  }
}
