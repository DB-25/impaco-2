import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
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
              firstElement(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleTag() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(children: <Widget>[
        Text(
          "Available Receivers",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Text(
            "Here is a list of registered people as recievers nearby the pincode you have entered",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        )
      ]),
    );
  }

  Widget firstElement() {
    return AspectRatio(
      aspectRatio: 353 / 110,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100,
                child: Column(
                  children: <Widget>[
                    Text("12",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        )
                    ),
                    Text("People",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        )
                    ),
                  ],),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Mohd Wasi"),
                    Text("8867861530"),
                    Text("H.No-1 Nai Basti, Bijnor"),
                    Text("246701"),
                  ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
