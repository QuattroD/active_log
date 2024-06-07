import 'dart:io';
import 'package:active_log/pages/daily_activity.dart';
import 'package:active_log/pages/reset_password.dart';
import 'package:active_log/pages/verification_email.dart';
import 'package:active_log/pages/verification_phone.dart';
import 'package:active_log/pages/welcome_pages/age.dart';
import 'package:active_log/pages/welcome_pages/gender.dart';
import 'package:active_log/pages/welcome_pages/goal.dart';
import 'package:active_log/pages/welcome_pages/tall.dart';
import 'package:active_log/pages/welcome_pages/weight.dart';
import 'package:active_log/pages/welcome_pages/welcome.dart';
import 'package:active_log/pages/workout.dart';
import 'package:active_log/services/user_data.dart';
import 'package:flutter/material.dart';
import 'package:active_log/pages/auth.dart';
import 'package:active_log/pages/reg.dart';
import 'package:active_log/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      String? uid = await UserPreferences.getUserUid();
  runApp(MyApp(initialRoute: uid != null ? '/home' : '/',));
}



class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ru', ''),
      ],
      locale: const Locale('ru', ''),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/': (context) => const AuthPage(),
        '/reg': (context) => const RegPage(),
        '/home': (context) => const HomePage(),
        '/activity': (context) => const DailyActivityPage(),
        '/workout': (context) => const WorkoutPage(),
        '/gender': (context) => const GenderPage(),
        '/age': (context) => const AgePage(),
        '/weight': (context) => const WeightPage(),
        '/tall': (context) => const TallPage(),
        '/goal': (context) => const GoalPage(),
        '/verification_email': (context) => const EmailVerificationPage(),
        '/verification_phone': (context) => const PhoneVerificationPage(),
        '/reset_password': (context) => const ResetPasswordPage(),
        //'/training_start': (context) => const TrainingStartPage()
      },
      
    );
  }
}
