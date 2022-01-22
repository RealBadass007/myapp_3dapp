import 'package:flutter/widgets.dart';
import 'package:myapp_3dapp/screens/complete_profile/complete_profile_screen.dart';
import 'package:myapp_3dapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:myapp_3dapp/screens/home/to_home_screen.dart';
import 'package:myapp_3dapp/screens/login_success/login_success_screen.dart';
import 'package:myapp_3dapp/screens/otp/otp_screen.dart';
import 'package:myapp_3dapp/screens/relax_screen.dart';
import 'package:myapp_3dapp/screens/sign_in/sign_in_screen.dart';
import 'package:myapp_3dapp/screens/sleep_screen.dart';
import 'package:myapp_3dapp/screens/splash/to_splash_screen.dart';

import 'contacts_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
var customRoutes = <String, WidgetBuilder>{

  '/home': (context) => ToHomeScreen(),

  '/splash': (context) => ToSplashScreen(),

  '/relax': (context) => RelaxScreen(),

  '/sleep': (context) => SleepScreen(),

  '/contact': (context) => ContactsScreen(),

  '/sign_in': (context) => SignInScreen(),

  ToHomeScreen.routeName: (context) => ToHomeScreen(),
  ToSplashScreen.routeName: (context) => ToSplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),

};