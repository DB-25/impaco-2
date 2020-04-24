import 'package:flutter/material.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/result_screen.dart';
import 'src/screens/form_screen.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/register_screen.dart';

void main() => runApp(MaterialApp(
      title: "Impaco",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      //home: ResultScreen(),
      //home: FormScreen(),
      //home: LoginScreen(),
      //home: RegisterScreen(),
    ));

//void main() => runApp(MyApp());
