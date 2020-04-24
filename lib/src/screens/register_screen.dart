import 'package:flutter/material.dart';
import 'package:impaco/src/component/input_field.dart';
import 'package:impaco/src/component/password_field.dart';
import 'package:impaco/src/models/api_response_model.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/apis/api_driver.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ApiDriver apiDriver = new ApiDriver();
  Future<ApiResponse<DataModel>> futureDataModel;

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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Email",
                        icon: Icons.face,
                        validator: emptyValidator("Email must not be empty"),
                        onSaved: (val) => formData['attrOne'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: PasswordField(
                        hintText: "Password",
                        icon: Icons.face,
                        validator: passwordValidator("Password must not be empty"),
                        onSaved: (val) => formData['attrTwo'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: PasswordField(
                        hintText: "Confirm Password",
                        icon: Icons.face,
                        validator: passwordValidator("Confirm password must not be empty"),
                        onSaved: (val) => formData['attrThr'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Referral Code",
                        icon: Icons.face,
                        validator: passwordValidator("Referral code must not be empty"),
                        onSaved: (val) => formData['attrThr'] = val,
                      ),
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
              padding: EdgeInsets.only(left: 100),
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

  Widget submitButton(ApiDriver apiDriver) {
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
            final dataModel = DataModel.fromMap(formData);
            futureDataModel = apiDriver.create(dataModel);
            FutureBuilder(
              future: futureDataModel,
              builder: (context, snapshot) {
                print(snapshot.data);
                return snapshot.data;
              },
            );
          },
        ),
      ],
    );
  }
}
