import 'package:flutter/material.dart';

class StackContainer extends StatelessWidget {
  const StackContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 180.0,
        color:  Color(0xfface2d3),
        child: Stack(
          children: <Widget>[
            Container(),
            // ClipPath(
            //   clipper: MyCustomClipper(),
            //   child: Container(
            //     height: 300.0,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: NetworkImage("https://picsum.photos/200"),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment(0, 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_pic.jpg'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Ameya",
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  // Text(
                  //   "Developer",
                  //   style: TextStyle(
                  //     fontSize: 12.0,
                  //     color: Colors.grey[700],
                  //   ),
                  // ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
