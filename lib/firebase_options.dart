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
    apiKey: 'AIzaSyBpsKoJqwDQkVr6oHfdmp-Yxw_tkK-rzXQ',
    appId: '1:149204024907:web:99d8305dc2a81a5f8e57ce',
    messagingSenderId: '149204024907',
    projectId: 'clearviewhcm-mobile-999',
    authDomain: 'clearviewhcm-mobile-999.firebaseapp.com',
    storageBucket: 'clearviewhcm-mobile-999.appspot.com',
    measurementId: 'G-QFKZBMLJL0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnyI2qgk996xm5Zp_SEORZGsxuuXGOyVw',
    appId: '1:149204024907:android:5ad078837920eab38e57ce',
    messagingSenderId: '149204024907',
    projectId: 'clearviewhcm-mobile-999',
    storageBucket: 'clearviewhcm-mobile-999.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUIYuqPJ6eN303PAKI4-RAJacNb1GhEu0',
    appId: '1:149204024907:ios:d887378c554c2bd98e57ce',
    messagingSenderId: '149204024907',
    projectId: 'clearviewhcm-mobile-999',
    storageBucket: 'clearviewhcm-mobile-999.appspot.com',
    iosClientId:
        '149204024907-5c17dsr8p8c74hsuoesrk2u55oqrridh.apps.googleusercontent.com',
    iosBundleId: 'com.blue.re',
  );
}
