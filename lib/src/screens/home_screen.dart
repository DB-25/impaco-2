import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impaco/src/screens/register_screen.dart';
import 'package:impaco/src/screens/result_screen.dart';

import 'form_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> homeDatas = [
    {
      'name': 'Student',
      'image': 'assets/student_icon.png',
      'color': Color(0xFF52A088),
      'description': 'Desc 1',
      'navigate': ResultScreen(),
    },
    {
      'name': 'Teacher',
      'image': 'assets/teacher_icon.png',
      'color': Color(0xFFDB6E8D),
      'description': 'Desc 2',
      'navigate': FormScreen(),
    },
//    {
//      'name': 'Login',
//      'image': 'assets/login.png',
//      'color': Color(0xFF678CC0),
//      'description': 'Desc 3',
//      'navigate': LoginScreen()
//    },
//    {
//      'name': 'Register',
//      'image': 'assets/signup_up.png',
//      'color': Color(0xFFC26CC5),
//      'description': 'Desc 4',
//      'navigate': RegisterScreen(),
//    }
  ];

  int yRatio = 120;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b2e44),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleTag(),
              Column(
                children: homeDatas
                    .map<Widget>((data) => Column(children: <Widget>[
                          Container(margin: EdgeInsets.only(bottom: 15)),
                          firstButton(context, data),
                        ]))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleTag() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Text(
        "Impaco",
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget firstButton(BuildContext context, var data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => data['navigate']),
        );
      },
      child: AspectRatio(
        aspectRatio: 353 / yRatio,
        child: Container(
          decoration: BoxDecoration(
            color: data['color'],
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 4),
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    data['image'],
//                  width: 34,
//                  height: 32,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      data['description'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//  Widget secondButton() {
//    return AspectRatio(
//      aspectRatio: 353 / yRatio,
//      child: Container(
//        decoration: BoxDecoration(
//          color: Color(0xFF52A088),
//          borderRadius: BorderRadius.circular(25),
//          boxShadow: [
//            BoxShadow(
//                offset: Offset(2, 4),
//                color: Colors.black.withOpacity(0.5),
//                blurRadius: 4),
//          ],
//        ),
//        child: Container(
//          margin: const EdgeInsets.all(14),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Image.asset(
//                "assets/hungry_icon.png",
//                width: 34,
//                height: 32,
//              ),
//              Padding(
//                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
//                child: Text(
//                  "Hungry",
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 14,
//                  ),
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//                child: Text(
//                  "There have been lot of food shortages in these trying times, Click here if you are in need.",
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 8,
//                  ),
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
}
