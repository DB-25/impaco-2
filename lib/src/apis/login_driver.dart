import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:impaco/src/models/api_response_model.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:impaco/src/models/login_model.dart';
import 'package:impaco/src/models/register_model.dart';

class LoginDriver {
  final String baseUrl = 'http://145.239.92.37:8080/auth-app/';
  final String companyId = 'ff8081817044351501715a08f5100006';
  String userType;

  Future<ApiResponse<DataModel>> create(RegisterModel registerModel) async {
    final http.Response response = await http.post(
      baseUrl + 'auth/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
        'email': registerModel.email,
        'password': registerModel.password,
        'confirmPassword': registerModel.confirmPassword,
        'contactNo': registerModel.contactNo,
        'userType': registerModel.userType,
      }),
    );
    print(response.statusCode);
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

  Future logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String> autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('password')) return null;
    LoginModel loginModel = LoginModel(
        email: prefs.getString('emailId'),
        password: prefs.getString('password'));
    if (loginModel.password != null) {
      final response = await login(loginModel);
      if (response.status) {
        String userType = getUserType();
        return userType;
      } else {
        return null;
      }
    }
    return null;
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('emailId'))
      return null;
    else
      return prefs.getString('emailId');
  }

  Future<ApiResponse<DataModel>> login(LoginModel loginModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      baseUrl + 'auth/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accessToken': 'dfgdh',
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
        'email': loginModel.email,
        'password': loginModel.password,
      }),
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to load data model');
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (!responseMap['status']) {
        throw Exception('Failed to load data model');
      } else {
        prefs.setString('password', loginModel.password);
        for (var data in responseMap['data']) {
          prefs.setString('accessToken', data['accessToken']);
          prefs.setString('emailId', loginModel.email);
          prefs.setString('userType', data['userType']);
          userType = data['userType'];
        }
        return ApiResponse.fromMap(responseMap);
      }
    }
  }

  String getUserType() {
    return userType;
  }
}
