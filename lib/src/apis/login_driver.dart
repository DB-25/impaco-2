import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:impaco/src/models/api_response_model.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginDriver {

  final String Base_Url = 'http://145.239.92.37:8080/auth-app/';
  final String companyId = '544ad65411d7182b4d1db6a525114b6b572b6eb7';

  Future<ApiResponse<DataModel>> create(DataModel dataModel) async {
    final http.Response response = await http.post(
      Base_Url+'auth/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
        'attrOne': dataModel.attrOne,
        'attrTwo': dataModel.attrTwo,
        'confirmPassword': dataModel.attrThree,
        'attrFour': dataModel.attrFour,
        'attrFive': dataModel.attrFive,
        'attrSix': dataModel.attrSix,
        'status': dataModel.status,
      }),
    );
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    //print(response.statusCode);
    if (response.statusCode != 200) {
      return ApiResponse.fromMap(responseMap);
      //throw Exception('Failed to save data');
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (!responseMap['status']) {
        throw Exception('Failed to load data model');
      } else {
        return ApiResponse.fromMap(responseMap);
      }
    }
  }

  Future<ApiResponse<DataModel>> login(DataModel dataModel) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Base_Url+'auth/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accessToken': 'dfgdh',
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
        'attrOne': dataModel.attrOne,
        'attrTwo': dataModel.attrTwo,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load data model');
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (!responseMap['status']) {
        throw Exception('Failed to load data model');
      } else {
        //print(responseMap['data']);
        for (var data in responseMap['data']) {
          //print(data['accessToken']);
          prefs.setString('accessToken', data['accessToken']);
          prefs.setString('emailId', dataModel.attrOne);
          prefs.setString('userType', data['userType']);
        }
        return ApiResponse.fromMap(responseMap);
      }
    }
  }

}
