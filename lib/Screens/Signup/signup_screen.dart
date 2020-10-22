import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatelessWidget {
  final String type;
  final FirebaseUser user;

  SignUpScreen({this.type, this.user});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  type,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  "${user.phoneNumber}",
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height*0.2,
                ),
                RaisedButton(
                  child: Text("CREATE USER"),
                  onPressed: () async{
                    await Firestore.instance.collection('Users').document(user.uid).setData({
                      'Email': 'jimmytheman@gmail.com',
                      'firstName': 'jimmy',
                      'LastName': "Goren",
                      'Location': 'Home, Israel'
                    });
                  },
                )


              ],
            )
        )
    );
  }
}
