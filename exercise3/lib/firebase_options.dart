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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAspVZbOMxGHdJbChNsA6X1Z9HvrToqjMM',
    appId: '1:65646270132:ios:865058fb3710b49458a9e1',
    messagingSenderId: '65646270132',
    projectId: 'mis-lab3-b837d',
    storageBucket: 'mis-lab3-b837d.firebasestorage.app',
    iosBundleId: 'com.example.newFlutterProject',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcR8e8OE_wwhBWf0DPPDh-9julazJ673E',
    appId: '1:65646270132:android:a2f084e55ee73cde58a9e1',
    messagingSenderId: '65646270132',
    projectId: 'mis-lab3-b837d',
    storageBucket: 'mis-lab3-b837d.firebasestorage.app',
  );

}