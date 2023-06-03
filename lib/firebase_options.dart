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
    apiKey: 'AIzaSyA1vYGgXSCQarn9sN-nBggWIlc9jysdytM',
    appId: '1:981961693233:web:71c0232a910bf06fae9d10',
    messagingSenderId: '981961693233',
    projectId: 'todo-app-8f649',
    authDomain: 'todo-app-8f649.firebaseapp.com',
    storageBucket: 'todo-app-8f649.appspot.com',
    measurementId: 'G-VT8L9NP9ZZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLf_Z-b6j2diRxDjUGA0-JtLwq7fd3y-o',
    appId: '1:981961693233:android:1caec001ac6c166dae9d10',
    messagingSenderId: '981961693233',
    projectId: 'todo-app-8f649',
    storageBucket: 'todo-app-8f649.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDT5W6pT9akPHf2UW184rc5DNfnTVl7Q6U',
    appId: '1:981961693233:ios:daa991876798748dae9d10',
    messagingSenderId: '981961693233',
    projectId: 'todo-app-8f649',
    storageBucket: 'todo-app-8f649.appspot.com',
    iosBundleId: 'com.mayank.todoapp',
  );
}