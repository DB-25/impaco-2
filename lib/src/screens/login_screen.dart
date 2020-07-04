import 'package:flutter/material.dart';
import 'package:impaco/src/apis/login_driver.dart';
import 'package:impaco/src/component/input_field.dart';
import 'package:impaco/src/component/password_field.dart';
import 'package:impaco/src/models/api_response_model.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/screens/register_screen.dart';
import 'package:impaco/src/screens/result_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LoginDriver loginDriver = new LoginDriver();
  Future<ApiResponse<DataModel>> futureDataModel;

  var formData = {
    'attrOne': '',
    'attrTwo': '',
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Email",
                        icon: Icons.email,
                        validator: emailValidator(),
                        onSaved: (val) => formData['attrOne'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: PasswordField(
                        hintText: "Password",
                        icon: Icons.lock,
                        validator:
                            passwordValidator("Password must not be empty"),
                        onSaved: (val) => formData['attrTwo'] = val,
                      ),
                    ),
                    submitButton(),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    signUpButton(),
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
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(children: <Widget>[
        SizedBox(
          height: 25.0,
        ),
        Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 75.0,
        ),
//        Padding(
//          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
//          child: Text(
//            "Register as a feeder or a help seeker.",
//            style: TextStyle(
//              color: Colors.white,
//              fontSize: 14,
//            ),
//          ),
//        ),
      ]),
    );
  }

  Widget submitButton() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () async {
                formKey.currentState.save();
                if (!formKey.currentState.validate()) return;
                final dataModel = DataModel.fromMap(formData);
                final response = await loginDriver.login(dataModel);
                if (response.status) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  _showMyDialog(
                      title: 'Login Failed',
                      body: 'Please check your email and password.');
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget signUpButton() {
    return Row(
      children: <Widget>[
        Text(
          "New to Impaco ? ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Padding(padding: EdgeInsets.only(left: 10)),
        RaisedButton(
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Sign up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
        ),
      ],
    );
  }

  Future<void> _showMyDialog({String title, String body}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(body),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
