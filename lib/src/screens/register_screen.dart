import 'package:flutter/material.dart';
import 'package:impaco/src/apis/login_driver.dart';
import 'package:impaco/src/component/input_field.dart';
import 'package:impaco/src/component/password_field.dart';
import 'package:impaco/src/models/api_response_model.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/models/register_model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LoginDriver loginDriver = new LoginDriver();
  Future<ApiResponse<DataModel>> futureDataModel;

  var formData = {
    'email': '',
    'password': '',
    'confirmPassword': '',
    'contactNo': '',
    'userType': 'Student',
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
                        icon: Icons.mail,
                        validator: emailValidator(),
                        onSaved: (val) => formData['email'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: PasswordField(
                        hintText: "Password",
                        icon: Icons.lock,
                        validator:
                            passwordValidator("Password must not be empty"),
                        onSaved: (val) => formData['password'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: PasswordField(
                        hintText: "Confirm Password",
                        icon: Icons.lock,
                        validator: passwordValidator(
                            "Confirm password must not be empty"),
                        onSaved: (val) => formData['confirmPassword'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Contact Number",
                        icon: Icons.contact_phone,
                        validator:
                            emptyValidator("Contact number must not be empty"),
                        onSaved: (val) => formData['contactNo'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 55.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.white,
                            value: formData['userType'],
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            dropdownColor: Color(0xFF2b2e44),
                            isExpanded: true,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            underline: Container(
                              height: 2,
                              color: Color(0xFF2b2e44),
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                formData['userType'] = newValue;
                              });
                            },
                            items: <String>['Student', 'Teacher']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    submitButton(),
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
        Row(
          children: <Widget>[
            Text(
              "Create Account",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 80),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.white,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Text(
            "Sign up for a new account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        )
      ]),
    );
  }

  Widget submitButton() {
    return Column(
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
            if (formData['password'] != formData['confirmPassword']) {
              _showMyDialog(
                  title: 'Check Password',
                  body: 'Please check your password.',
                  goToLogin: false);
              return;
            }
            final registerModel = RegisterModel.fromMap(formData);
            Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
            final response = await loginDriver.create(registerModel);
//            print(response.status);
            if (response.status) {
              _showMyDialog(
                  title: 'Registered Successfully',
                  body: 'Please login.',
                  goToLogin: true);
            } else {
              _showMyDialog(
                  title: 'Registration Failed',
                  body: 'Please try again later.',
                  goToLogin: false);
            }
          },
        ),
      ],
    );
  }

  Future<void> _showMyDialog(
      {String title, String body, bool goToLogin}) async {
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
                if (goToLogin) Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
