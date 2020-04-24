import 'package:flutter/material.dart';
import 'package:impaco/src/component/input_field.dart';
import 'package:impaco/src/component/password_field.dart';
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
  Future<DataModel> futureDataModel;

  var formData = {
    'email': '',
    'password': '',
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
                        icon: Icons.face,
                        validator: emptyValidator("Email must not be empty"),
                        onSaved: (val) => formData['email'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: PasswordField(
                        hintText: "Password",
                        icon: Icons.face,
                        validator: passwordValidator("Password must not be empty"),
                        onSaved: (val) => formData['password'] = val,
                      ),
                    ),
                    submitButton(apiDriver),
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

  Widget submitButton(ApiDriver apiDriver) {
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
      ],
    );
  }

  Widget signUpButton() {
    return Row(
      children: <Widget>[
        Text("New to Educato ? ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Padding(padding: EdgeInsets.only(left: 10)),
        RaisedButton(
          color: Colors.blue,
          child: Text('Sign up',
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
}
