import 'package:flutter/material.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/apis/api_driver.dart';
import 'package:impaco/src/component/input_field.dart';

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
                        hintText: "Full Name",
                        icon: Icons.face,
                        validator:
                            emptyValidator("Full Name must not be empty"),
                        onSaved: (val) => formData['attrOne'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Contact Number",
                        icon: Icons.face,
                        validator:
                            emptyValidator("Contact Number must not be empty"),
                        onSaved: (val) => formData['attrTwo'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Full Name",
                        icon: Icons.face,
                        validator:
                            emptyValidator("Full Name must not be empty"),
                        onSaved: (val) => formData['attrOne'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Full Name",
                        icon: Icons.face,
                        validator:
                            emptyValidator("Full Name must not be empty"),
                        onSaved: (val) => formData['attrOne'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InputField(
                        hintText: "Full Name",
                        icon: Icons.face,
                        validator:
                            emptyValidator("Full Name must not be empty"),
                        onSaved: (val) => formData['attrOne'] = val,
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
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 180),
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

  Widget dateField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Date',
        hintText: 'Date',
      ),
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: null,
          lastDate: DateTime(2020),
        ).then((date) {
          setState(() {
            var day = date.day;
          });
        });
      },
      onSaved: (String value) {
        formData['attrSix'] = value;
      },
    );
  }

  Widget timeField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Time',
        hintText: 'Time',
      ),
      onTap: () {
        showTimePicker(context: context, initialTime: TimeOfDay.now());
      },
      onSaved: (String value) {
        formData['attrSix'] = value;
      },
    );
  }

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
              setState(() {
                formKey.currentState.save();
                final dataModel = DataModel.fromMap(formData);
                final response = apiDriver.create(dataModel);
                //_futureDataModel = create();
              });
            },
          ),
        ),
      ],
    );
  }
}
