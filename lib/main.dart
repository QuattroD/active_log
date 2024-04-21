import 'dart:io';

import 'package:flutter/material.dart';
import 'package:active_log/auth.dart';
import 'package:active_log/reg.dart';
import 'package:active_log/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyBtNwlLtDFXaE0OLyO00jau6cyNwLAmyHU',
              appId: '1:809706057161:android:f25a4dc0caa1d22b858c18',
              messagingSenderId: '809706057161',
              projectId: 'active-log-9c62f'))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        '/reg': (context) => const RegPage(),
        '/home': (context) => const HomePage(),
        //'/settings': (context) => const SettingsPage(),
      },
    );
  }
}
