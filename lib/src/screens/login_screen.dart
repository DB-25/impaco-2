import 'package:flutter/material.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/apis/api_driver.dart';
import 'package:impaco/src/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
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
                    emailField(),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    passwordField(),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    submitButton(apiDriver),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    signupButton(),
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
          "Login",
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

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Enter email',
        hintText: 'Enter email',
      ),
      onSaved: (String value) {
        formData['attrOne'] = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Enter password',
        hintText: 'Enter password',
      ),
      onSaved: (String value) {
        formData['attrTwo'] = value;
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

  Widget signupButton() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("New to Educato ? "),
            Padding(padding: EdgeInsets.only(left: 10)),
            RaisedButton(
              color: Colors.blue,
              child: Text('Sign up'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
