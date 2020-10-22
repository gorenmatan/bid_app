import 'package:flutter/material.dart';
import '../../components/rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class SignUpIntroScreen extends StatelessWidget {
  //final FirebaseUser user;

  //SignUpIntroScreen({this.user});

  void _showRegistrationForm(context){
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          height: size.height*0.9,
          color: Colors.teal,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Edit Trip", style: TextStyle(color: Colors.cyan,)),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.blue,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              Text("matan", style: TextStyle(color: Colors.green,)),
            ],
          ),
        );
      }
    );
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
                  "MATAN GOREN",
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
                  height: size.height*0.2,
                ),
                RoundedButton(
                  text: "CUSTOMER",
                  radius: 20.0,
                  press: () {
                    print("customer");
                    _showRegistrationForm(context);
                    /*
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen(
                              user: user,
                              type: 'customer',
                            )));

                     */
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
                    print("supplier");
                    showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel,
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (BuildContext buildContext,
                            Animation animation,
                            Animation secondaryAnimation) {
                          return Scaffold(
                            body: SafeArea(
                              child: Container(
                                width: size.width,
                                height: size.height,

                                color: Colors.deepOrangeAccent,
                                child: Column(
                                  children: [
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
                                              Navigator.of(context).pop();
                                            },
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size.height*0.1,),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                CircleAvatar(
                                                  radius: 60,
                                                  backgroundColor: Colors.grey[50],
                                                  child: ClipOval(
                                                    child: SizedBox(
                                                      width: 110.0,
                                                      height: 110.0,
                                                      child: Image.network(
                                                        "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top:60.0),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.camera_alt,
                                                      size: 30.0,
                                                    ),
                                                    onPressed: () {

                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 10.0,),

                                            SizedBox(height: 20.0,),
                                            TextFormField(
                                              style: TextStyle(color: Colors.white),
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                                      borderSide: BorderSide.none
                                                  ),

                                                  hintStyle: TextStyle(color: Colors.white,fontFamily: "WorkSansLight"),
                                                  filled: true,
                                                  fillColor: Colors.white24,
                                                  hintText: 'Full Name'),
                                            ),
                                            SizedBox(height: 16.0,),
                                            TextFormField(
                                              style: TextStyle(color: Colors.white),
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.email,
                                                    color: Colors.white,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    // width: 0.0 produces a thin "hairline" border
                                                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                                      borderSide: BorderSide.none
                                                    //borderSide: const BorderSide(),
                                                  ),

                                                  hintStyle: TextStyle(color: Colors.white,fontFamily: "WorkSansLight"),
                                                  filled: true,
                                                  fillColor: Colors.white24,
                                                  hintText: 'Email Address'),
                                            ),
                                          ],
                                        ),
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),

              ],
            )
        )
      ),
    );
  }
}
