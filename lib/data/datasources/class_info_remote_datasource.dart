import 'dart:convert';

import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/data/models/response/class_info_details_response_model.dart';
import 'package:fath_school/data/models/response/class_info_response_model.dart';
import 'package:http/http.dart' as http;

class ClassInfoRemoteDatasource {
  Future<List<ClassInfoResponseModel>> getClassInfo() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/course');
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
      return data.map((e) => ClassInfoResponseModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<ClassInfoDetailsResponseModel> getClassInfoById(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/course/$id');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return ClassInfoDetailsResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}