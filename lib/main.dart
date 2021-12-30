import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:myapp_3dapp/custom_drawer_guitar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp_3dapp/screens/complete_profile/complete_profile_screen.dart';
import 'package:myapp_3dapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:myapp_3dapp/screens/login_success/login_success_screen.dart';
import 'package:myapp_3dapp/screens/otp/otp_screen.dart';
import 'package:myapp_3dapp/screens/sign_in/sign_in_screen.dart';
import 'package:myapp_3dapp/screens/sign_up/sign_up_screen.dart';
import 'package:myapp_3dapp/screens/splash/splash_screen.dart';
import 'contacts_screen.dart';
import 'screens/home.dart';
import 'custom_drawer.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'screens/focus_screen.dart';
import 'screens/relax_screen.dart';
import 'screens/sleep_screen.dart';
import 'package:myapp_3dapp/size_config.dart';


PageController pageController = PageController(initialPage: 0);
int currentIndex = 0;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp(

  )
  );
}

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
    Widget child = MyHomePage(appBar: appBar);
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
        '/home': (context) =>MyHomePage(),

        '/relax': (context) => RelaxScreen(),

        '/sleep': (context) => SleepScreen(),

        '/contact': (context) => ContactsScreen(),

        '/sign_in': (context) => SignInScreen(),

        '/splash': (context) => SplashScreen(),

        SignInScreen.routeName: (context) => SignInScreen(),
        ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
        LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
        OtpScreen.routeName: (context) => OtpScreen(),
        // HomeScreen.routeName: (context) => HomeScreen(),

      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:child,
    );
  }
}

class MyHomePage extends StatefulWidget {

  final AppBar appBar;

  MyHomePage({Key key, @required this.appBar}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfface2d3),
      appBar: AppBar(
        title: Text(' '),
        centerTitle: true,
        backgroundColor: Color(0xfface2d3),
        elevation: 0.0,

        actions: <Widget>[

          // PopupMenuButton<String>(
          //   onSelected: choiceAction,
          //   itemBuilder: (BuildContext context){
          //     return Constants.choices.map((String choice){
          //       return PopupMenuItem<String>(
          //         value: choice,
          //
          //         child: Text(choice),
          //       );
          //     }).toList();
          //   },
          // )
        ],
      ),
      body: Stack(
        children: [
          Flexible(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                FocusScreen(),
                RelaxScreen(),
                SleepScreen(),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar:CustomBottomNavigationBar(),

    );
  }
}



