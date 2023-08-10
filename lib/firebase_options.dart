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
    apiKey: 'AIzaSyCeHD9RfcnYn61GsiqGoCp_uWGzR0el6xc',
    appId: '1:605119364804:web:be5876aea9931c4cfd5391',
    messagingSenderId: '605119364804',
    projectId: 'mychat-7e407',
    authDomain: 'mychat-7e407.firebaseapp.com',
    storageBucket: 'mychat-7e407.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXEHbzSU0_wFvX_Ll1Wl9NV2liszKQI3I',
    appId: '1:605119364804:android:a4ed4e38f95aa19efd5391',
    messagingSenderId: '605119364804',
    projectId: 'mychat-7e407',
    storageBucket: 'mychat-7e407.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBedvxVCBeA6dq-JBr1FQc0ZHRe9BCtrKY',
    appId: '1:605119364804:ios:87adeb400eb86a0efd5391',
    messagingSenderId: '605119364804',
    projectId: 'mychat-7e407',
    storageBucket: 'mychat-7e407.appspot.com',
    iosClientId: '605119364804-u6a3d6kt1mp4r36ej541q6j0fal4u1b3.apps.googleusercontent.com',
    iosBundleId: 'com.example.mychat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBedvxVCBeA6dq-JBr1FQc0ZHRe9BCtrKY',
    appId: '1:605119364804:ios:87adeb400eb86a0efd5391',
    messagingSenderId: '605119364804',
    projectId: 'mychat-7e407',
    storageBucket: 'mychat-7e407.appspot.com',
    iosClientId: '605119364804-u6a3d6kt1mp4r36ej541q6j0fal4u1b3.apps.googleusercontent.com',
    iosBundleId: 'com.example.mychat',
  );
}
