import 'dart:async';
import 'package:flutter/material.dart';
import 'package:impaco/src/component/input_field.dart';
import 'package:impaco/src/apis/api_driver.dart';
import 'package:impaco/src/models/course_model.dart';
import 'package:impaco/src/models/api_response_model.dart';
import 'package:impaco/src/screens/course_screen.dart';

class CourseForm extends StatefulWidget {
  final CourseModel courseModel;
  final bool update;
  CourseForm({this.update, this.courseModel});
  @override
  _CourseFormState createState() =>
      _CourseFormState(update: update, courseModel: courseModel);
}

final formKey = GlobalKey<FormState>();
final scaffoldKey = GlobalKey<ScaffoldState>();

class _CourseFormState extends State<CourseForm> {
  final CourseModel courseModel;
  final bool update;
  _CourseFormState({this.update, this.courseModel});
  var formData = {
    'name': '',
    'title': '',
    'instructor': '',
    'websiteLink': '',
    'platform': '',
    'courseLink': '',
    'status': 'Active',
  };

  ApiDriver apiDriver = new ApiDriver();
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
        appBar: AppBar(
          backgroundColor: Color(0xFF2b2e44),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('REGISTER'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
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
                        hintText: "Course Name",
                        icon: Icons.school,
                        validator:
                            emptyValidator("Course Name must not be empty"),
                        onSaved: (val) => formData['name'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Title",
                        icon: Icons.laptop,
                        validator: emptyValidator("Title must not be empty"),
                        onSaved: (val) => formData['title'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Platform",
                        icon: Icons.web,
                        validator: emptyValidator("Platform must not be empty"),
                        onSaved: (val) => formData['platform'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Course Link",
                        icon: Icons.insert_link,
                        validator: emptyValidator("Enter a valid URL"),
                        onSaved: (val) => formData['courseLink'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Instructor's Name",
                        icon: Icons.person,
                        validator: emptyValidator(
                            "Instructor's Name must not be empty"),
                        onSaved: (val) => formData['instructor'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Website Link",
                        icon: Icons.insert_link,
                        validator:
                            emptyValidator("Website Link must not be empty"),
                        onSaved: (val) => formData['websiteLink'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 60.0, right: 30, top: 2),
                              child: DropdownButton<String>(
                                iconEnabledColor: Colors.white,
                                value: formData['status'],
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                elevation: 16,
                                dropdownColor: Color(0xFF2b2e44),
                                isExpanded: true,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Color(0xFF2b2e44),
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    formData['status'] = newValue;
                                  });
                                },
                                items: <String>[
                                  'Active',
                                  'In Active',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 17.0, left: 19.0),
                              child: Icon(
                                Icons.apps,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
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

  Widget submitButton(ApiDriver apiDriver) {
    return Center(
      child: RaisedButton(
        color: Color(0xFF2DA488),
        child: Container(
          height: 50,
          width: double.infinity,
          child: Center(
            child: Text(
              "REGISTER",
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
          final newCourseModel = CourseModel.fromMap(formData);
          ApiResponse response = (update)
              ? await apiDriver.updateCourse(newCourseModel)
              : await apiDriver.createCourse(newCourseModel);
          CourseScreenState courseScreenState = CourseScreenState();
          courseScreenState.refreshBool = true;
          if (response.message == "Successfully Saved") {
            _showMyDialog(
                title: 'Successfully Saved',
                body: 'Your Course has been Registered.',
                goToLogin: false);
          }
          Timer(Duration(seconds: 1), () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CourseScreen()))
                .then((value) {
              courseScreenState.refreshBool = true;
              courseScreenState.refresh();
            });
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget titleTag() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Center(
          child: Text(
            "Register new Courses",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
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
                if (goToLogin) Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
