import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:impaco/src/models/data_model.dart';

class DataApiDriver {
  Future<DataModel> create(DataModel dataModel) async {
    final http.Response response = await http.post(
      'http://145.239.92.37:8080/fagnum-api/feeder/create',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accessToken': 'dfgdh',
      },
      body: jsonEncode(<String, String>{
        'attrOne': dataModel.attrOne,
        'attrTwo': dataModel.attrTwo,
        'attrThree': dataModel.attrThree,
        'attrFour': dataModel.attrFour,
        'attrFive': dataModel.attrFive,
        'attrSix': dataModel.attrSix,
        'status': dataModel.status,
      }),
    );
    if (response.statusCode == 200) {
      print(response);
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      return DataModel.fromMap(json.decode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
