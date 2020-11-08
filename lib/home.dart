import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() : super();

  final String title = "Maps Demo";

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(Icons.chat), onPressed: () {}),
              IconButton(icon: Icon(Icons.history), onPressed: () {}),
              IconButton(icon: Icon(Icons.person), onPressed: () {}),
              IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
            ],
          ),
        ),
      body: Text("MATAN GOREN"),
      );
  }
}


