import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
              firstButton(),
              Container(margin: EdgeInsets.only(bottom:20),),
              secondButton(),
              Container(margin: EdgeInsets.only(bottom:20),),
              thirdButton(),
              Container(margin: EdgeInsets.only(bottom:20),),
              fourthButton(),
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

  Widget firstButton() {
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
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hungry",
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

  Widget thirdButton() {
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

  Widget fourthButton() {
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
