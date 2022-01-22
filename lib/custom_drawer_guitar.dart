import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens/splash/splash_screen.dart';
import 'package:myapp_3dapp/services/authentication_service.dart';
import 'package:provider/src/provider.dart';
import 'clipper/wave_clipper1.dart';

class CustomGuitarDrawer extends StatefulWidget {
  final Widget child;

  const CustomGuitarDrawer({Key key, this.child}) : super(key: key);

  static CustomGuitarDrawerState of(BuildContext context) =>
      context.findAncestorStateOfType<CustomGuitarDrawerState>();

  @override
  CustomGuitarDrawerState createState() => new CustomGuitarDrawerState();
}

class CustomGuitarDrawerState extends State<CustomGuitarDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool _canBeDragged = false;
  final double maxSlide = 300.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.translucent,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Material(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(maxSlide * (animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: MyDrawer(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: widget.child,
                  ),
                ),
                Positioned(
                  top: 4.0 + MediaQuery.of(context).padding.top,
                  left: 4.0 + animationController.value * maxSlide,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: toggle,
                    color: Colors.white,
                  ),
                ),

                Positioned(
                  top: 16.0 + MediaQuery.of(context).padding.top,
                  left: animationController.value *
                      MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'D3 App',

                    style: TextStyle(
                      color: Colors.black54,
                      fontSize:20 ,
                      fontWeight:FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: double.infinity,

      child: Material(
        color: Color(0xfface2d3),
        child: SafeArea(

          child: Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [

                // Image.asset(
                //   'assets/flutter_europe_white.png',
                //   width: 200,
                // ),
                ListTile(
                  onTap: () {
                    context.read<AuthenticationService>().signOut();

                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new SplashScreen ())
                    );
                  },
                  leading: Icon(Icons.login_rounded,color:Colors.black54),
                  title:  Text(
                    'Logout',
                    style: TextStyle(color: Colors.black54,
                      //  fontSize:20 ,
                      fontWeight:FontWeight.w700,),
                  ),

                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new SplashScreen ())
                    );},
                  leading: Icon(Icons.star,color:Colors.black54),
                  title:  Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black54,
                      //  fontSize:20 ,
                      fontWeight:FontWeight.w700,),
                  ),
                ),
                ListTile(

                  leading: Icon(Icons.contact_support,color:Colors.black54),
                  title:  Text(
                    'Contact Support',
                    style: TextStyle(color: Colors.black54,
                    //  fontSize:20 ,
                      fontWeight:FontWeight.w700,),
                  ),
                ),
                ListTile(
                  focusColor:Colors.black,
                  leading: Icon(Icons.corporate_fare_rounded , color:Colors.black54),
                  title: Text(
                    'About Us',
                    style: TextStyle(color: Colors.black54,
                      //  fontSize:20 ,
                      fontWeight:FontWeight.w700,),
                  ),
                ),
                // ListTile(
                //   focusColor:Colors.black,
                //   leading: Icon(Icons.person, color:Colors.black54),
                //   title: Text(
                //     'Profile',
                //     style: TextStyle(color: Colors.black54,
                //       //  fontSize:20 ,
                //       fontWeight:FontWeight.w700,),
                //   ),
                // ),
                SizedBox(height: 399.0),
                Positioned(
                  child: ClipPath(
                    clipper: WaveClipper1(),
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff00a86b).withAlpha(150),
                            Color(0xff00a86b),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}