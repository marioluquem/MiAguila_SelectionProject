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
    apiKey: 'AIzaSyBl9JyNBNiqTHn31G_tgK3GXtRjX1j6h2I',
    appId: '1:95496385863:web:2e772ba747915b85ab4862',
    messagingSenderId: '95496385863',
    projectId: 'miaguila-store-jobtest',
    authDomain: 'miaguila-store-jobtest.firebaseapp.com',
    storageBucket: 'miaguila-store-jobtest.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5npAEe6UPTEslN3zVzBsUvND_smxCZUg',
    appId: '1:95496385863:android:94459e112bcf7164ab4862',
    messagingSenderId: '95496385863',
    projectId: 'miaguila-store-jobtest',
    storageBucket: 'miaguila-store-jobtest.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQEmugN6u-CUYkV7gaUFofYI43E36vsRM',
    appId: '1:95496385863:ios:4fd4d27a65b81749ab4862',
    messagingSenderId: '95496385863',
    projectId: 'miaguila-store-jobtest',
    storageBucket: 'miaguila-store-jobtest.appspot.com',
    iosClientId: '95496385863-1v1u5pk2rs8g3nkh2osk16c12qasegep.apps.googleusercontent.com',
    iosBundleId: 'com.marioluque.mistorejob',
  );
}