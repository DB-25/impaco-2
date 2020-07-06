import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impaco/src/apis/login_driver.dart';
import 'package:impaco/src/component/input_field.dart';
import 'package:impaco/src/component/password_field.dart';
import 'package:impaco/src/models/api_response_model.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/models/login_model.dart';
import 'package:impaco/src/screens/register_screen.dart';
import 'package:impaco/src/screens/result_screen.dart';
import 'teachers_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  autoLogin() async {
    final String userType = await loginDriver.autoLogIn();
    if (userType == "Student") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResultScreen()));
    } else if (userType == "Teacher") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TeachersScreen()));
    } else {
      return;
    }
  }

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LoginDriver loginDriver = new LoginDriver();
  Future<ApiResponse<DataModel>> futureDataModel;

  var formData = {
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF2b2e44),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 20.0,
                        ),
                        Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  input(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an Account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Color(0xFF2DA488),
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget input() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: InputField(
            hintText: "Email",
            icon: Icons.email,
            validator: emailValidator(),
            onSaved: (val) => formData['email'] = val,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: PasswordField(
            hintText: "Password",
            icon: Icons.lock,
            validator: passwordValidator("Password must not be empty"),
            onSaved: (val) => formData['password'] = val,
          ),
        ),
        RaisedButton(
          color: Color(0xFF2DA488),
          child: Container(
            height: 50,
            width: double.infinity,
            child: Center(
              child: Text(
                "LOGIN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () async {
            formKey.currentState.save();
            if (!formKey.currentState.validate()) return;
            final loginModel = LoginModel.fromMap(formData);
            final response = await loginDriver.login(loginModel);
            if (response.status) {
              String userType = loginDriver.getUserType();
              print(userType);
              if (userType == "Student") {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ResultScreen()));
              } else {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => TeachersScreen()));
              }
            } else {
              _showMyDialog(
                  title: 'Login Failed',
                  body: 'Please check your email and password.');
            }
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
