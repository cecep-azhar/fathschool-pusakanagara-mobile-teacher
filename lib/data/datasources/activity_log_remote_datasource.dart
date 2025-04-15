import 'dart:convert';

import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/data/models/response/activitylog_response_model.dart';
import 'package:http/http.dart' as http;

class ActivityLogRemoteDatasource {
  Future<List<ActivityLogResponseModel>> getActivityLogs(int userId) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/activity-logs/$userId');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
      return data.map((e) => ActivityLogResponseModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}