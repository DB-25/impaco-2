import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
              secondButton(),
              thirdButton(),
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
      aspectRatio: 353 / 176,
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
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                child: Text(
                  "Hungry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                child: Text(
                  "There have been lot of food shortages in these trying times, Click here if you are in need.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget secondButton() {
    return AspectRatio(
      aspectRatio: 353 / 176,
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
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                child: Text(
                  "Hungry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                child: Text(
                  "There have been lot of food shortages in these trying times, Click here if you are in need.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
      aspectRatio: 353 / 176,
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
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                child: Text(
                  "Hungry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                child: Text(
                  "There have been lot of food shortages in these trying times, Click here if you are in need.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
      aspectRatio: 353 / 176,
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
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                child: Text(
                  "Hungry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                child: Text(
                  "There have been lot of food shortages in these trying times, Click here if you are in need.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
