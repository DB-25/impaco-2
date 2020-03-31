import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
