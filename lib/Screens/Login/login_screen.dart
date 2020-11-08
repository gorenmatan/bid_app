import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterbidapp/Screens/Signup/signup_intro_screen.dart';
import 'package:flutterbidapp/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterbidapp/home.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 10),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();
          User user  = (await _auth.signInWithCredential(credential)).user;
          if (user != null) {
            try {
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user.uid)
                  .get()
                  .then((doc) {
                if (doc.exists) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                //user: user,
                              )));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpIntroScreen(
                                user: user,
                              )));
                }
              });
            } catch (e) {
              print(e);
            }
          } else {
            print("Error here");
          }
          // gets called when auto code is applied.
        },
        verificationFailed: (FirebaseAuthException exception) {
          print("faild");
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Insert the code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: kTealPrimaryColor,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);

                        UserCredential result =
                            await _auth.signInWithCredential(credential);

                        User user = result.user;

                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpIntroScreen(
                                      user: user,
                                      )));
                        } else {
                          print("Error confirm");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Code Time Out");
        });
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  bool validPhoneNumber(String phone) {
    String patttern = r'(^(?:0?[689])?[0-9]{8}$)';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(phone)) {
      return false;
    }
    return true;
  }

  final _formKey = GlobalKey<FormState>();
  bool is_valid = true;
  String _error;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  showAlert(),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    "BID APP",
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Image.asset(
                    "assets/images/diamond.png",
                    height: 120.0,
                    width: 120.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "FIND BEST BIDS AND BUY",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.22,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    width: size.width * 0.88,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90.0),
                      color: Colors.white,
                      border: Border.all(
                          color: !is_valid ? Colors.red : Colors.black38),
                    ),
                    child: Row(
                      children: <Widget>[
                        Image.asset('icons/flags/png/il.png',
                            height: 16.0,
                            width: 26.0,
                            package: 'country_icons'),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "+972",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            autofocus: false,
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Enter your mobile number'),
                            controller: _phoneController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                    width: size.width * 0.88,
                    child: !is_valid
                        ? Text(
                            "Required Field",
                            style: TextStyle(color: Colors.red),
                          )
                        : null,
                  ),
                  Container(
                    width:size.width*0.88,
                    child: RoundedButton(
                      text: "ENTER",
                      radius: 90.0,
                      press: () {
                        final phone = _phoneController.text.trim();
                        if (phone.isEmpty) {
                          setState(() {
                            is_valid = false;
                          });
                        }
                        /*else if(!validPhoneNumber(phone)){
                          setState(() {
                            is_valid = true;
                            _error = 'Please enter valid mobile number';
                          });
                        }*/
                        else {
                          loginUser('+972$phone', context);
                          setState(() {
                            is_valid = true;
                            _error = null;
                          });
                        }
                      },
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
