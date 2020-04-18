import 'package:flutter/material.dart';
import 'package:impaco/src/models/data_model.dart';

class FormScreen extends StatefulWidget {
  FormScreen({Key key}) : super(key: key);

  @override
  FormScreenState createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {

  final TextEditingController teController = TextEditingController();
  Future<DataModel> _futureDataModel;

  String attrOne = '';
  String attrTwo = '';
  String attrThree = '';
  String attrFour = '';
  String attrFive = '';
  String attrSix = '';

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
              nameField(teController),
              Container(margin: EdgeInsets.only(bottom:20),),
              contactNoField(teController),
              Container(margin: EdgeInsets.only(bottom:20),),
              noOfPeopleField(teController),
              Container(margin: EdgeInsets.only(bottom:20),),
              pincodeField(teController),
              Container(margin: EdgeInsets.only(bottom:20),),
              typeField(teController),
              Container(margin: EdgeInsets.only(bottom:20),),
              submitButton(teController),
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

  Widget nameField(TextEditingController teController) {
    return TextFormField(
      controller: teController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Enter Name',
        hintText: 'Enter Name',
      ),
      onSaved: (String value) {
        attrOne = value;
      },
    );
  }

  Widget contactNoField(TextEditingController teController) {
    return TextFormField(
      controller: teController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter contact no',
        hintText: 'Enter contact no.',
      ),
      onSaved: (String value) {
        attrTwo = value;
      },
    );
  }

  Widget noOfPeopleField(TextEditingController teController) {
    return TextFormField(
      controller: teController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'No of People',
        hintText: 'No of People',
      ),
      onSaved: (String value) {
        attrThree = value;
      },
    );
  }

  Widget addressField(TextEditingController teController) {
    return TextFormField(
      controller: teController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Addess',
        hintText: 'Address',
      ),
      onSaved: (String value) {
        attrFour = value;
      },
    );
  }

  Widget pincodeField(TextEditingController teController) {
    return TextFormField(
      controller: teController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Pin code',
        hintText: 'Pin code',
      ),
      onSaved: (String value) {
        attrFive = value;
      },
    );
  }

  Widget typeField(TextEditingController teController) {
    return TextFormField(
      controller: teController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter contact no',
        hintText: 'Enter contact no.',
      ),
      onSaved: (String value) {
        attrSix = value;
      },
    );
  }

  Widget submitButton(TextEditingController teController) {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: () {
        setState(() {
          _futureDataModel = create();
        });
      },
    );
  }
}
