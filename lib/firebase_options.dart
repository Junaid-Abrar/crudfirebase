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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDlbW9OXeUbiPqD5uD38QUmEDJAReanRTk',
    appId: '1:1037272525605:web:29b812afe952b6549c88cc',
    messagingSenderId: '1037272525605',
    projectId: 'fluttercrud-21148',
    authDomain: 'fluttercrud-21148.firebaseapp.com',
    storageBucket: 'fluttercrud-21148.appspot.com',
    measurementId: 'G-BZ8BC1CZPQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYbaayyfajxcZCMovD8vxn9z__qZMapWc',
    appId: '1:1037272525605:android:2d6f88ce80cbbf689c88cc',
    messagingSenderId: '1037272525605',
    projectId: 'fluttercrud-21148',
    storageBucket: 'fluttercrud-21148.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3-AOXvOuOJuOgzcVgDrIk8PnPPX3DvrM',
    appId: '1:1037272525605:ios:716a0c4ca0fc519c9c88cc',
    messagingSenderId: '1037272525605',
    projectId: 'fluttercrud-21148',
    storageBucket: 'fluttercrud-21148.appspot.com',
    iosBundleId: 'com.example.crudfirebase',
  );
}