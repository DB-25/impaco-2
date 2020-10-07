import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:impaco/src/models/api_response_model.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:impaco/src/models/course_model.dart';

class ApiDriver {
  final String baseUrl = 'https://api.fagnum.com/';
  // final String baseUrl = 'http://145.239.92.37:8080/fagnum-test-api/';
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

  Future<ApiResponse<DataModel>> createCourse(CourseModel courseModel) async {
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.post(
      baseUrl + 'course/create',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + prefs.getString('accessToken'),
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
        'name': courseModel.name,
        'title': courseModel.title,
        'instructor': courseModel.instructor,
        'courseLink': courseModel.courseLink,
        'platform': courseModel.platform,
        'websiteLink': courseModel.websiteLink,
        'status': courseModel.status
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

  Future<ApiResponse<DataModel>> updateCourse(CourseModel courseModel) async {
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.post(
      baseUrl + 'course/update',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + prefs.getString('accessToken'),
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
        'courseId': courseModel.courseId,
        'name': courseModel.name,
        'title': courseModel.title,
        'instructor': courseModel.instructor,
        'courseLink': courseModel.courseLink,
        'platform': courseModel.platform,
        'websiteLink': courseModel.websiteLink,
        'status': courseModel.status
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

  Future<List<CourseModel>> readCourse() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      baseUrl + 'course/read',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + prefs.getString('accessToken'),
      },
      body: jsonEncode(<String, String>{
        'companyId': companyId,
      }),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to load data model');
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (!responseMap['status']) {
        throw Exception('Failed to load data model');
      } else {
        List<CourseModel> courseModelList = [];
        for (var courseModel in responseMap['data']) {
          courseModelList.add(CourseModel.fromMap(courseModel));
        }
        return courseModelList;
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
}
