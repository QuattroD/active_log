import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final int duration;
  final String navigateAfterSeconds;
  final Image image;
  final Color backgroundColor;
  final Color loaderColor;
  final double photoSize;
  const SplashScreen({
    super.key,
    this.duration = 2,
    required this.navigateAfterSeconds,
    required this.image,
    required this.backgroundColor,
    required this.loaderColor,
    required this.photoSize,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: widget.duration),
      () => Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: widget.photoSize,
              height: widget.photoSize,
              child: widget.image,
            ),
            SizedBox(height: 10.0),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(widget.loaderColor),
            ),
          ],
        ),
      ),
    );
  }
}
