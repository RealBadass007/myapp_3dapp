import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp_3dapp/services/authentication_service.dart';
import 'package:myapp_3dapp/services/create_model.dart';
import 'package:myapp_3dapp/services/database_service.dart';
import 'package:myapp_3dapp/services/predict_user_state.dart';
import 'package:provider/provider.dart';
import 'services/authentication_wrapper.dart';

import 'package:open_location_code/open_location_code.dart' as olc;

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseService dbs = new DatabaseService();
    dbs.CheckModel();
    //dbs.UploadModel();

    //Map Co-ordinates
    //print(olc.decode("7JFJ5RW6+9M Mumbai, Maharashtra".split(' ').first).center.latitude.toString());

    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        Provider<DatabaseService>(
          create: (_) => DatabaseService(),
        ),
        StreamProvider(
          create: (context) =>
          context
              .read<AuthenticationService>()
              .authStateChanges,
        )
      ],
      child: AuthenticationWrapper(),
    );
  }
}