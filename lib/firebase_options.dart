// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBnmyonGoUQuHAB2juqt8K7P5XC5gBPLI0',
    appId: '1:954199389267:web:9978014d6a0293f36c02a6',
    messagingSenderId: '954199389267',
    projectId: 'venkateshwara-app-edfcf',
    authDomain: 'venkateshwara-app-edfcf.firebaseapp.com',
    storageBucket: 'venkateshwara-app-edfcf.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDI_qUNDF_bdKt0x7X-ibmMTsv9jT2kiDw',
    appId: '1:954199389267:android:752b6ae04e394b7d6c02a6',
    messagingSenderId: '954199389267',
    projectId: 'venkateshwara-app-edfcf',
    storageBucket: 'venkateshwara-app-edfcf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxDpaPmolDfSOp_OFs84x0AVAYLecNLIs',
    appId: '1:954199389267:ios:9d676571552840c06c02a6',
    messagingSenderId: '954199389267',
    projectId: 'venkateshwara-app-edfcf',
    storageBucket: 'venkateshwara-app-edfcf.appspot.com',
    iosBundleId: 'com.example.sugarMillApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxDpaPmolDfSOp_OFs84x0AVAYLecNLIs',
    appId: '1:954199389267:ios:9d676571552840c06c02a6',
    messagingSenderId: '954199389267',
    projectId: 'venkateshwara-app-edfcf',
    storageBucket: 'venkateshwara-app-edfcf.appspot.com',
    iosBundleId: 'com.example.sugarMillApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBnmyonGoUQuHAB2juqt8K7P5XC5gBPLI0',
    appId: '1:954199389267:web:598eec9df1c4e1356c02a6',
    messagingSenderId: '954199389267',
    projectId: 'venkateshwara-app-edfcf',
    authDomain: 'venkateshwara-app-edfcf.firebaseapp.com',
    storageBucket: 'venkateshwara-app-edfcf.appspot.com',
  );

}