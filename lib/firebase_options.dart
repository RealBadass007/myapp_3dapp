// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAfAausZ6HWGGgj-dnBKpQXaZMDTMvgaYc',
    appId: '1:1058956894345:web:92333b395dbdb5d9156658',
    messagingSenderId: '1058956894345',
    projectId: 'tcet-a16-5dapp',
    authDomain: 'tcet-a16-5dapp.firebaseapp.com',
    storageBucket: 'tcet-a16-5dapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAy6P9nbXKB3kNIaPlvT4Ev8JP4H0gjjxk',
    appId: '1:1058956894345:android:0d60e05725dab727156658',
    messagingSenderId: '1058956894345',
    projectId: 'tcet-a16-5dapp',
    storageBucket: 'tcet-a16-5dapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBO8GjReu62fu_fA1mrnoz1f6aZ2W9W6z0',
    appId: '1:1058956894345:ios:42f5cf3056495458156658',
    messagingSenderId: '1058956894345',
    projectId: 'tcet-a16-5dapp',
    storageBucket: 'tcet-a16-5dapp.appspot.com',
    iosClientId: '1058956894345-4v24t48jbi780cukeu22nl28ot5ibi38.apps.googleusercontent.com',
    iosBundleId: 'com.5d.app',
  );
}
