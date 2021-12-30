import 'package:flutter/material.dart';
class UberScreen extends StatelessWidget {

  // This widget is the root
  // of your application

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " ",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xfface2d3),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/uber_home2.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: null /* add child content here */,
        ),
      ),
    );

  }
}