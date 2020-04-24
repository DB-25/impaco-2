import 'package:flutter/material.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/apis/api_driver.dart';

class FormScreen extends StatefulWidget {
  @override
  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ApiDriver apiDriver = new ApiDriver();
  final TextEditingController teController = TextEditingController();
  Future<DataModel> futureDataModel;

  var formData = {
    'attrOne': '',
    'attrTwo': '',
    'attrThr': '',
    'attrFour': '',
    'attrFive': '',
    'attrSix': '',
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF2b2e44),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    titleTag(),
                    nameField(),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    contactNoField(),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    noOfPeopleField(),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    pinCodeField(),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    typeField(),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    submitButton(apiDriver),
                  ],
                ),
              ),
            ),
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
        formData['attrOne'] = value;
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
        formData['attrTwo'] = value;
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
        formData['attrThr'] = value;
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
        formData['attrFour'] = value;
      },
    );
  }

  Widget pinCodeField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Pin code',
        hintText: 'Pin code',
      ),
      onSaved: (String value) {
        formData['attrFive'] = value;
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
        formData['attrSix'] = value;
      },
    );
  }

  Widget submitButton(ApiDriver apiDriver) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text('Submit'),
              onPressed: () async {
                setState(() {
                  formKey.currentState.save();
                  final dataModel = DataModel.fromMap(formData);
                  final response = apiDriver.create(dataModel);
                  //_futureDataModel = create();
                });
              },
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(left: 30)),
        Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ],
    );
  }
}
