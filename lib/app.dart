import 'package:myapp_3dapp/custom_drawer_guitar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp_3dapp/screens/card_screen.dart';
import 'package:myapp_3dapp/screens/complete_profile/complete_profile_screen.dart';
import 'package:myapp_3dapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:myapp_3dapp/screens/login_success/login_success_screen.dart';
import 'package:myapp_3dapp/screens/otp/otp_screen.dart';
import 'package:myapp_3dapp/screens/progress_screen.dart';
import 'package:myapp_3dapp/screens/sign_in/sign_in_screen.dart';
import 'package:myapp_3dapp/screens/sign_up/sign_up_screen.dart';
import 'package:myapp_3dapp/screens/splash/splash_screen.dart';
import 'package:myapp_3dapp/screens/splash1/splash_screen1.dart';
import 'package:myapp_3dapp/screens/type_screen.dart';
import 'package:myapp_3dapp/screens/uber_screen.dart';

import 'contacts_screen.dart';
import 'main.dart';
import 'home_screen.dart';
import 'screens/home.dart';
import 'custom_drawer.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'screens/focus_screen.dart';
import 'screens/relax_screen.dart';
import 'screens/sleep_screen.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool flip = false;
    AppBar appBar = flip
        ? AppBar()
        : AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => CustomDrawer.of(context).open(),
          );
        },
      ),
      // title: Text('.....'),
    );
    Widget child = HomeScreen(appBar: appBar);
    // if (flip) {
    child = CustomGuitarDrawer(child: child);
    // }
    //    else {
    // child = CustomDrawer(child: child);
    //   }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'D3 App',
      routes: {
        '/home': (context) => HomeScreen(),

        '/relax': (context) => RelaxScreen(),

        '/sleep': (context) => SleepScreen(),

        '/contact': (context) => ContactsScreen(),

        '/sign_in': (context) => SignInScreen(),

        '/splash': (context) => SplashScreen(),

        '/splash1': (context) => SplashScreen1(),

        '/progress': (context) => CustomProgressIndicator(),

        '/uber': (context) => UberScreen(),

        '/type': (context) => TypeScreen(),

        '/card': (context) => CardScreen(),

        SignInScreen.routeName: (context) => SignInScreen(),
        ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
        LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
        OtpScreen.routeName: (context) => OtpScreen(),


      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:child,
    );
  }
}
