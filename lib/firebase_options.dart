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
    apiKey: 'AIzaSyDuZ6Hf9Uw3RdB7vsnHplSKR3pPT9QJfkU',
    appId: '1:173983308935:web:a6cf81579194f19405ec22',
    messagingSenderId: '173983308935',
    projectId: 'fdc-aj-quiz-app',
    authDomain: 'fdc-aj-quiz-app.firebaseapp.com',
    storageBucket: 'fdc-aj-quiz-app.appspot.com',
    measurementId: 'G-Z3FC7LGG35',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmb7UU3Waq76cgY2lURLrYIGvG9agX6Y4',
    appId: '1:173983308935:android:8b44954f997a979a05ec22',
    messagingSenderId: '173983308935',
    projectId: 'fdc-aj-quiz-app',
    storageBucket: 'fdc-aj-quiz-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJFov9-pGcugLt277UarrKeXPRxQ1SAjs',
    appId: '1:173983308935:ios:f44cbeb68844b74205ec22',
    messagingSenderId: '173983308935',
    projectId: 'fdc-aj-quiz-app',
    storageBucket: 'fdc-aj-quiz-app.appspot.com',
    iosClientId:
        '173983308935-kafbrk2aq749acasd4qsutf106bmfnqo.apps.googleusercontent.com',
    iosBundleId: 'com.interneers.fdcAjQuizApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJFov9-pGcugLt277UarrKeXPRxQ1SAjs',
    appId: '1:173983308935:ios:f44cbeb68844b74205ec22',
    messagingSenderId: '173983308935',
    projectId: 'fdc-aj-quiz-app',
    storageBucket: 'fdc-aj-quiz-app.appspot.com',
    iosClientId:
        '173983308935-kafbrk2aq749acasd4qsutf106bmfnqo.apps.googleusercontent.com',
    iosBundleId: 'com.interneers.fdcAjQuizApp',
  );
}
