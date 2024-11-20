import 'package:flutter/material.dart';
import 'OnboardingScreen.dart';

class FlavorFiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlavorFi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: OnboardingScreen(),
    );
  }
}

void main() {
  runApp(FlavorFiApp());
}