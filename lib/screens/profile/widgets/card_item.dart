import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Container(
            width:310.0,
            height:71 ,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 21.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.access_time,
                    //     size: 40.0,
                    //     color: Colors.green,
                    //   ),
                    // ),
                    SizedBox(width: 24.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Date Of Birth",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          "21 August 2000",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          Container(
            width:310.0,
            height:71 ,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 21.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.access_time,
                    //     size: 40.0,
                    //     color: Colors.green,
                    //   ),
                    // ),
                    SizedBox(width: 24.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Join Date",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          "19 July 2020",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          Container(
            width:310.0,
            height:71 ,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 21.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.access_time,
                    //     size: 40.0,
                    //     color: Colors.green,
                    //   ),
                    // ),
                    SizedBox(width: 24.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Previous Result",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          "Passed",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          // Container(
          //   width:310.0,
          //   height:71 ,
          //   child: Card(
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 16.0,
          //         vertical: 21.0,
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: <Widget>[
          //           // IconButton(
          //           //   onPressed: () {},
          //           //   icon: Icon(
          //           //     Icons.access_time,
          //           //     size: 40.0,
          //           //     color: Colors.green,
          //           //   ),
          //           // ),
          //           SizedBox(width: 24.0),
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisSize: MainAxisSize.min,
          //             children: <Widget>[
          //               Text(
          //                 "Previous Result",
          //                 style: TextStyle(
          //                   fontSize: 18.0,
          //                 ),
          //               ),
          //               SizedBox(width: 16.0),
          //               Text(
          //                 "21 August 2020",
          //                 style: TextStyle(
          //                   color: Colors.grey[700],
          //                   fontSize: 18.0,
          //                 ),
          //               ),
          //             ],
          //           ),
          //
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            width:310.0,
            height:71 ,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 21.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.access_time,
                    //     size: 40.0,
                    //     color: Colors.green,
                    //   ),
                    // ),
                    SizedBox(width: 24.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Previous Result",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          "27 August 2020",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}