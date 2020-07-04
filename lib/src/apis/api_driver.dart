import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:impaco/src/models/api_response_model.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiDriver {
  final String baseUrl = 'http://145.239.92.37:8080/fagnum-api/';
  final String companyId = 'ff8081817044351501715a08f5100006';

  Future<ApiResponse<DataModel>> create(DataModel dataModel) async {
    final prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.post(
      baseUrl + 'classes/create',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + prefs.getString('accessToken'),
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
        'name': dataModel.name,
        'subject': dataModel.subject,
        'startDate': dataModel.startDate,
        'startTime': dataModel.startTime,
        'appName': dataModel.appName,
        'meetingLink': dataModel.meetingLink,
        'status': "Active",
        'emailId': prefs.getString('emailId'),
      }),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to save data');
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (!responseMap['status']) {
        throw Exception('Failed to load data model');
      } else {
        return ApiResponse.fromMap(responseMap);
      }
    }
  }

  Future<List<DataModel>> read() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      baseUrl + 'classes/read',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + prefs.getString('accessToken'),
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
        'emailId': prefs.getString('emailId'),
      }),
    );
    //final response = await http.get('http://145.239.92.37:8080/fagnum-api/feeder/read');
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to load data model');
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (!responseMap['status']) {
        throw Exception('Failed to load data model');
      } else {
        List<DataModel> dataModelList = [];
        for (var dataModel in responseMap['data']) {
          dataModelList.add(DataModel.fromMap(dataModel));
        }
        return dataModelList;
      }
    }
  }

//  Future<List<DataModel>> read1() async {
//    final response = await http.post(
//      'http://145.239.92.37:8080/fagnum-api/feeder/read',
//      headers: <String, String>{
//        'Content-Type': 'application/json; charset=UTF-8',
//        'accessToken': 'dfgdh',
//      },
//      body: jsonEncode(<String, String>{}),
//    );
//    //final response = await http.get('http://145.239.92.37:8080/fagnum-api/feeder/read');
//    if (response.statusCode != 200) {
//      throw Exception('Failed to load data model');
//    } else {
//      ApiResponse apiResponse = ApiResponse.fromMap(jsonDecode(response.body));
//      print(apiResponse);
//      if (!apiResponse.status) {
//        throw Exception('Failed to load data model');
//      } else {
//        List<DataModel> dataModelList = [];
//        for (var dataModel in apiResponse.data) {
//          dataModelList.add(DataModel.fromMap(dataModel));
//        }
//        return dataModelList;
//      }
//    }
//  }
}
