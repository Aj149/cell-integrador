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
    apiKey: 'AIzaSyBWiq9I7XOxrGRq47XFkmMStUtQacFaBJQ',
    appId: '1:675924406501:web:1b1dc0646eb1d3a867240c',
    messagingSenderId: '675924406501',
    projectId: 'tienda-e3221',
    authDomain: 'tienda-e3221.firebaseapp.com',
    storageBucket: 'tienda-e3221.appspot.com',
    measurementId: 'G-XJ67W95L0N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBa0lRD4RvweyVSV-2aIpvvWJyQANJ630',
    appId: '1:675924406501:android:dc2d611274677b6867240c',
    messagingSenderId: '675924406501',
    projectId: 'tienda-e3221',
    storageBucket: 'tienda-e3221.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuwGO0eumRypLgomhEb92-nKzol0tEEyU',
    appId: '1:675924406501:ios:56c9e5622987ca1d67240c',
    messagingSenderId: '675924406501',
    projectId: 'tienda-e3221',
    storageBucket: 'tienda-e3221.appspot.com',
    iosBundleId: 'com.example.movilappMain',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuwGO0eumRypLgomhEb92-nKzol0tEEyU',
    appId: '1:675924406501:ios:56c9e5622987ca1d67240c',
    messagingSenderId: '675924406501',
    projectId: 'tienda-e3221',
    storageBucket: 'tienda-e3221.appspot.com',
    iosBundleId: 'com.example.movilappMain',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBWiq9I7XOxrGRq47XFkmMStUtQacFaBJQ',
    appId: '1:675924406501:web:10d8e4ad32edeaca67240c',
    messagingSenderId: '675924406501',
    projectId: 'tienda-e3221',
    authDomain: 'tienda-e3221.firebaseapp.com',
    storageBucket: 'tienda-e3221.appspot.com',
    measurementId: 'G-Z38PXWY5MG',
  );
}
