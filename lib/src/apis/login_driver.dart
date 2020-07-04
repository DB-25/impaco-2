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
      Base_Url + 'auth/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
        'attrOne': dataModel.name,
        'attrTwo': dataModel.subject,
        'confirmPassword': dataModel.startDate,
        'attrFour': dataModel.startTime,
        'attrFive': dataModel.appName,
        'attrSix': dataModel.meetingLink,
        'status': dataModel.status,
      }),
    );
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return ApiResponse.fromMap(responseMap);
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
      Base_Url + 'auth/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accessToken': 'dfgdh',
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
        'attrOne': dataModel.name,
        'attrTwo': dataModel.subject,
      }),
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to load data model');
      return null;
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (!responseMap['status']) {
        throw Exception('Failed to load data model');
      } else {
        for (var data in responseMap['data']) {
          prefs.setString('accessToken', data['accessToken']);
          prefs.setString('emailId', dataModel.name);
          prefs.setString('userType', data['userType']);
        }
        return ApiResponse.fromMap(responseMap);
      }
    }
  }
}
