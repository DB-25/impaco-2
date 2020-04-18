import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class DataModel {
  String primaryId;
  String attrOne;
  String attrTwo;
  String attrThree;
  String attrFour;
  String attrFive;
  String attrSix;
  String status;

  DataModel({
    this.primaryId,
    this.attrOne,
    this.attrTwo,
    this.attrThree,
    this.attrFour,
    this.attrFive,
    this.attrSix,
    this.status
  });

  factory DataModel.fromJson(Map<String, dynamic> parsedJson) {
    return DataModel(
        primaryId : parsedJson['primaryId'],
        attrOne : parsedJson['attrOne'],
        attrTwo : parsedJson['attrTwo'],
        attrThree : parsedJson['attrThree'],
        attrFour : parsedJson['attrFour'],
        attrFive : parsedJson['attrFive'],
        status : parsedJson['status'],
    );
  }

  Future<DataModel> create(String title) async {
    final http.Response response = await http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accessToken': 'dfgdh',
      },
      body: jsonEncode(<String, String>{
        'attrOne': attrOne,
        'attrTwo': attrTwo,
        'attrThree': attrThree,
        'attrFour': attrFour,
        'attrFive': attrFive,
        'attrSix': attrSix,
        'status': status,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      return DataModel.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}