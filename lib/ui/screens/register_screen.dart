import 'package:flutter/material.dart';
import 'package:impaco/strings.dart';
import 'package:impaco/ui/components/register_form_field.dart';
import 'package:impaco/ui/impaco_theme.dart';

import '../screen_utils.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  var _formData = {
    'fullName': '',
    'contactNumber': '',
    'numberOfPeople': '',
    'address': '',
    'pinCode': '',
    'type': 'Donor',
  };

  final _types = <String>[
    'Donor',
    'Reciever',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: iw(30), right: iw(30), top: iw(20)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                      ),
                      Text(
                        Strings.register,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: iw(36),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: ih(38),
                  ),
                  Text(
                    Strings.registerDesc,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Container(
                    height: ih(38),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RegisterFormField(
                      hintText: "Full Name",
                      icon: Icons.face,
                      validator: emptyValidator("Full Name must not be empty"),
                      onSaved: (val) => _formData['fullName'] = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RegisterFormField(
                      hintText: "Contact Number",
                      icon: Icons.phone,
                      validator:
                          emptyValidator("Contact Number must not be empty"),
                      onSaved: (val) => _formData['contactNumber'] = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RegisterFormField(
                      hintText: "Number of People",
                      icon: Icons.supervisor_account,
                      validator:
                          emptyValidator("Number of People must not be empty"),
                      onSaved: (val) => _formData['numberOfPeople'] = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RegisterFormField(
                      hintText: "Address",
                      icon: Icons.home,
                      validator: emptyValidator("Address must not be empty"),
                      onSaved: (val) => _formData['address'] = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RegisterFormField(
                      hintText: "PIN Code",
                      icon: Icons.location_on,
                      validator: emptyValidator("PIN Code must not be empty"),
                      onSaved: (val) => _formData['pinCode'] = val,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white.withOpacity(0.2))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 5),
                      child: DropdownButton<String>(
                        style: TextStyle(
                          inherit: false,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                        ),
                        underline: Container(),
                        isExpanded: true,
                        value: _formData['type'],
                        items: _types.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value, style: TextStyle(color: Colors.black),),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _formData['type'] = val;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
