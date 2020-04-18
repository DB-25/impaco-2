import 'package:flutter/material.dart';
import 'package:impaco/src/screens/album_screen.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/result_screen.dart';
import 'src/screens/form_screen.dart';

void main() => runApp(MaterialApp(
  title: "Impaco",
  theme: ThemeData(primarySwatch: Colors.blue),
  //home: HomeScreen(),
  //home: ResultScreen(),
  home: FormScreen(),
));

//void main() => runApp(MyApp());
