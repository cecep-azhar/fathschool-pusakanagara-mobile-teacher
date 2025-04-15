import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/data/models/response/leaves_type_response_model.dart';
import 'package:fath_school/data/models/response/permission_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PermissonRemoteDatasource {
  Future<Either<String, String>> addPermission(String leaveTypeId, String start,
      String end, String title, String description, XFile? image) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-permissions');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    var request = http.MultipartRequest('POST', url);

    request.headers.addAll(headers);
    request.fields['leave_type_id'] = leaveTypeId;
    request.fields['start'] = start;
    request.fields['end'] = end;
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.files.add(await http.MultipartFile.fromPath('image', image!.path));

    http.StreamedResponse response = await request.send();
    
    if (response.statusCode == 201) {
      return const Right('Permission added successfully');
    } else {
      return const Left('Failed to add permission');
    }
  }

  Future<List<PermissionResponseModel>> getListPermission() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-permissions');
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
      return data.map((e) => PermissionResponseModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<PermissionResponseModel> getDetailPermissionId(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/permissions/$id');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return PermissionResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<LeavesTypeResponseModel>> getLeavesId() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/permissions-type');
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
      return data.map((e) => LeavesTypeResponseModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
