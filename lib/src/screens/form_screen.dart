import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  String name = '';
  String contactNo = '';
  String noOfPeople = '';
  String address = '';
  String pincode = '';
  String type = '';

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
              nameField(),
              Container(margin: EdgeInsets.only(bottom:20),),
              contactNoField(),
              Container(margin: EdgeInsets.only(bottom:20),),
              noOfPeopleField(),
              Container(margin: EdgeInsets.only(bottom:20),),
              pincodeField(),
              Container(margin: EdgeInsets.only(bottom:20),),
              typeField(),
              Container(margin: EdgeInsets.only(bottom:20),),
              submitButton(),
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
          "Register",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Text(
            "Register as a feeder or a help seeker.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        )
      ]),
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

  Widget noOfPeopleField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'No of People',
        hintText: 'No of People',
      ),
      onSaved: (String value) {
        noOfPeople = value;
      },
    );
  }

  Widget addressField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Addess',
        hintText: 'Address',
      ),
      onSaved: (String value) {
        address = value;
      },
    );
  }

  Widget pincodeField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Pin code',
        hintText: 'Pin code',
      ),
      onSaved: (String value) {
        pincode = value;
      },
    );
  }

  Widget typeField() {
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

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: () {
        //Navigator.push(
        //context,
        //MaterialPageRoute(builder: (context) => FeederScreenState()),
        //);
      },
    );
  }
}
