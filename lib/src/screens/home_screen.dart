import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            hungryButton(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            feederButton(),
          ],
        ),
      ),
    );
  }

  Widget hungryButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Hungry'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HungryScreenState()),
        );
      },
    );
  }

  Widget feederButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Feeder'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeederScreenState()),
        );
      },
    );
  }
}

class HungryScreenState extends StatelessWidget {
  String name = '';
  String contactNo = '';

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            nameField(),
            contactNoField(),
          ],
        ),
      ),
    );
  }

  Widget nameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Enter Name',
        hintText: 'Enter Name',
      ),
      onSaved: (String value) {
        name = value;
      },
    );
  }

  Widget contactNoField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter contact no',
        hintText: 'Enter contact no.',
      ),
      onSaved: (String value) {
        contactNo = value;
      },
    );
  }
}

class FeederScreenState extends StatelessWidget {
  String name = '';
  String contactNo = '';

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            nameField(),
            contactNoField(),
          ],
        ),
      ),
    );
  }

  Widget nameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Enter Name',
        hintText: 'Enter Name',
      ),
      onSaved: (String value) {
        name = value;
      },
    );
  }

  Widget contactNoField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter contact no',
        hintText: 'Enter contact no.',
      ),
      onSaved: (String value) {
        contactNo = value;
      },
    );
  }
}
