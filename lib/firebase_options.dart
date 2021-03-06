// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBgqmZvq-d8pNqr6vwfukHQJmGiV1JwDZo',
    appId: '1:1090197961748:web:1ada0ca96f0a113b4c3b01',
    messagingSenderId: '1090197961748',
    projectId: 'zeromin-study',
    authDomain: 'zeromin-study.firebaseapp.com',
    storageBucket: 'zeromin-study.appspot.com',
    measurementId: 'G-G69M2ETFVL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3umZieskQX31_5Z5t9XAJGymKzBlqBUQ',
    appId: '1:1090197961748:android:a41c6ac0c2f9eea64c3b01',
    messagingSenderId: '1090197961748',
    projectId: 'zeromin-study',
    storageBucket: 'zeromin-study.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYM0yoB_PaENlckanJLwbsHFGc3SJeIsQ',
    appId: '1:1090197961748:ios:ecd6bc8b582d794d4c3b01',
    messagingSenderId: '1090197961748',
    projectId: 'zeromin-study',
    storageBucket: 'zeromin-study.appspot.com',
    iosClientId: '1090197961748-41ho8e7fg2bohsjjbpo86r553grq3miq.apps.googleusercontent.com',
    iosBundleId: 'com.zeromin0520.flutterstudy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYM0yoB_PaENlckanJLwbsHFGc3SJeIsQ',
    appId: '1:1090197961748:ios:ecd6bc8b582d794d4c3b01',
    messagingSenderId: '1090197961748',
    projectId: 'zeromin-study',
    storageBucket: 'zeromin-study.appspot.com',
    iosClientId: '1090197961748-41ho8e7fg2bohsjjbpo86r553grq3miq.apps.googleusercontent.com',
    iosBundleId: 'com.zeromin0520.flutterstudy',
  );
}
