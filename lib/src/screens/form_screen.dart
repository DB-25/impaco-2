import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/apis/api_driver.dart';
import 'package:impaco/src/component/input_field.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatefulWidget {
  @override
  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ApiDriver apiDriver = new ApiDriver();
  Future<DataModel> futureDataModel;

  var formData = {
    'attrOne': '',
    'attrTwo': '',
    'attrThree': '',
    'attrFour': '',
    'attrFive': 'Google Meet',
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
                        onSaved: (val) => formData['attrOne'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Subject",
                        icon: Icons.subject,
                        validator: emptyValidator("Subject must not be empty"),
                        onSaved: (val) => formData['attrTwo'] = val,
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
                              formData['attrThree'] =
                                  DateFormat('yyyy-MM-dd ').format(date);
                              formData['attrFour'] =
                                  DateFormat('kk:mm').format(date);
                              print(formData['attrThree']);
                              print(formData['attrFour']);
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
                                'Choose Date and Time',
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.white,
                            value: formData['attrFive'],
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
                                formData['attrFive'] = newValue;
                              });
                            },
                            items: <String>[
                              'Google Meet',
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Link",
                        icon: Icons.insert_link,
                        validator: emptyValidator("Link must not be empty"),
                        onSaved: (val) => formData['attrSix'] = val,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.white,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Text(
            "Register your future class.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        )
      ]),
    );
  }

//  Widget nameField() {
//    return TextFormField(
//      keyboardType: TextInputType.text,
//      decoration: InputDecoration(
//        labelText: 'Enter Name',
//        hintText: 'Enter Name',
//      ),
//      onSaved: (String value) {
//        formData['attrOne'] = value;
//      },
//    );
//  }
//
//  Widget contactNoField() {
//    return TextFormField(
//      keyboardType: TextInputType.number,
//      decoration: InputDecoration(
//        labelText: 'Enter contact no',
//        hintText: 'Enter contact no.',
//      ),
//      onSaved: (String value) {
//        formData['attrTwo'] = value;
//      },
//    );
//  }
//
//  Widget dateField(BuildContext context) {
//    return TextFormField(
//      decoration: InputDecoration(
//        labelText: 'Date',
//        hintText: 'Date',
//      ),
//      onTap: () {
//        showDatePicker(
//          context: context,
//          initialDate: DateTime.now(),
//          firstDate: null,
//          lastDate: DateTime(2020),
//        ).then((date) {
//          setState(() {
//            var day = date.day;
//          });
//        });
//      },
//      onSaved: (String value) {
//        formData['attrSix'] = value;
//      },
//    );
//  }
//
//  Widget timeField(BuildContext context) {
//    return TextFormField(
//      decoration: InputDecoration(
//        labelText: 'Time',
//        hintText: 'Time',
//      ),
//      onTap: () {
//        showTimePicker(context: context, initialTime: TimeOfDay.now());
//      },
//      onSaved: (String value) {
//        formData['attrSix'] = value;
//      },
//    );
//  }

  Widget submitButton(ApiDriver apiDriver) {
    return Row(
      children: <Widget>[
        Center(
          child: RaisedButton(
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
              if (formData['attrThree'] == '' || formData['attrFour'] == '') {
                _showMyDialog(
                    title: 'Failed',
                    body: 'Please choose a Date and Time.',
                    goToLogin: false);
              }
              final dataModel = DataModel.fromMap(formData);
              final response = apiDriver.create(dataModel);
            },
          ),
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
