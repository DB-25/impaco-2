import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'form_screen.dart';

class HomeScreen extends StatelessWidget {
  var homeData = [
    {
      'name': 'Hungry',
      'image': 'assets/hungry_icon.png',
      'color': '0xFF52A088',
    },
    {
      'name': 'Feeder',
      'image': 'assets/feed_people.png',
      'color': '0xFFDB6E8D',
    },
    {
      'name': 'Login',
      'image': 'assets/login.png',
      'color': '0xFF678CC0',
    },
    {
      'name': 'Register',
      'image': 'assets/signup_up.png',
      'color': '0xFFC26CC5',
    }
  ];
  var wOneData = {
    'name': 'Hungry',
    'image': 'assets/hungry_icon.png',
    'color': '0xFF52A088'
  };
  var wTwoData = {
    'name': 'Feeder',
    'image': 'assets/feed_people.png',
    'color': '0xFFDB6E8D'
  };
  var wThrData = {
    'name': 'Login',
    'image': 'assets/login.png',
    'color': '0xFF678CC0'
  };
  var wFourData = {
    'name': 'Register',
    'image': 'assets/signup_up.png',
    'color': '0xFFC26CC5'
  };
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
              firstButton(context, wOneData),
              Container(
                margin: EdgeInsets.only(bottom: 20),
              ),
              firstButton(context, wTwoData),
              Container(
                margin: EdgeInsets.only(bottom: 20),
              ),
              firstButton(context, wThrData),
              Container(
                margin: EdgeInsets.only(bottom: 20),
              ),
              firstButton(context, wFourData),
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
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget firstButton(BuildContext context, var wOneData1) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormScreen()),
        );
      },
      child: AspectRatio(
        aspectRatio: 353 / yRatio,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF52A088),
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
                Image.asset(
                  wOneData1['image'],
                  width: 34,
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      wOneData1['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "There have been lot of food shortages in these trying times, Click here if you are in need.",
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

  Widget secondButton() {
    return AspectRatio(
      aspectRatio: 353 / yRatio,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF52A088),
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
              Image.asset(
                "assets/hungry_icon.png",
                width: 34,
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                child: Text(
                  "Hungry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Text(
                  "There have been lot of food shortages in these trying times, Click here if you are in need.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
