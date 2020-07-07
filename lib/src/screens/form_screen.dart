import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/apis/api_driver.dart';
import 'package:impaco/src/component/input_field.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:impaco/src/models/api_response_model.dart';
import 'teachers_screen.dart';
import 'dart:async';

class FormScreen extends StatefulWidget {
  final String email;
  FormScreen(this.email);
  @override
  FormScreenState createState() => FormScreenState(email);
}

class FormScreenState extends State<FormScreen> {
  String email;
  FormScreenState(this.email);
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ApiDriver apiDriver = new ApiDriver();
  Future<DataModel> futureDataModel;

  var formData = {
    'name': '',
    'subject': '',
    'startDate': '',
    'startTime': '',
    'appName': 'Google Meet',
    'meetingLink': '',
  };

  void setDate() {
    final _dateTime = DateTime.now();
    setState(() {
      formData['startDate'] =
          DateFormat('dd-MMM-yyyy').format(_dateTime).toString();
      formData['startTime'] = DateFormat('h:mm a').format(_dateTime).toString();
    });
  }

  @override
  void initState() {
    setDate();
    super.initState();
  }

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
                        hintText: "Class Name",
                        icon: Icons.school,
                        validator:
                            emptyValidator("Class Name must not be empty"),
                        onSaved: (val) => formData['name'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Subject",
                        icon: Icons.subject,
                        validator: emptyValidator("Subject must not be empty"),
                        onSaved: (val) => formData['subject'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2020, 3, 5),
                                maxTime: DateTime(2030, 6, 7),
                                onConfirm: (date) {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                formData['startDate'] =
                                    DateFormat('dd-MMM-yyyy')
                                        .format(date)
                                        .toString();
                                formData['startTime'] = DateFormat('h:mm a')
                                    .format(date)
                                    .toString();
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                " " +
                                    formData['startDate'].toString() +
                                    "     " +
                                    formData['startTime'].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
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
                                value: formData['appName'],
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
                                    formData['appName'] = newValue;
                                  });
                                },
                                items: <String>[
                                  'Google Meet',
                                  'Jio Meet',
                                  'ZOOM',
                                  'Google Duo',
                                  'Skype',
                                  'Discord'
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: InputField(
                        hintText: "Link",
                        icon: Icons.insert_link,
                        validator: emptyValidator("Enter a valid URL"),
                        onSaved: (val) => formData['meetingLink'] = val,
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
            Padding(
              padding: EdgeInsets.only(left: 95, right: 55),
              child: Text(
                "Schedule",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
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
            "Schedule your next class.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        )
      ]),
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
              "SCHEDULE",
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
          if (formData['startDate'] == '' || formData['startTime'] == '') {
            _showMyDialog(
                title: 'Failed',
                body: 'Please choose a Date and Time.',
                goToLogin: false);
          }
          final dataModel = DataModel.fromMap(formData);
          ApiResponse response = await apiDriver.create(dataModel);
          TeachersScreenState teachersScreen = TeachersScreenState(email);
          teachersScreen.refreshBool = true;
          if (response.message == 'Successfully Saved') {
            _showMyDialog(
                title: 'Successfully Saved',
                body: 'Your Class has been Scheduled.',
                goToLogin: false);
          }
          Timer(Duration(seconds: 3), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TeachersScreen(email))).then((value) {
              teachersScreen.refreshBool = true;
              teachersScreen.refresh();
            });
          });
        },
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
