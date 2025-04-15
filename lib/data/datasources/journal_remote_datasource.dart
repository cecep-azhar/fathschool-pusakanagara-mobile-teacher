import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/data/models/response/journal_response_model.dart';
import 'package:http/http.dart' as http;

class JournalRemoteDatasource {
   Future<Either<String, String>> addJournal(
      String date, String time, String description, String image, String classLists) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/journal');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    var request = http.MultipartRequest('POST', url);

    request.headers.addAll(headers);
    request.fields['date'] = date;
    request.fields['time'] = time;
    request.fields['description'] = description;
    request.fields['course_id'] = classLists;

    if (image.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('img', image));
    }

    try {
      final http.StreamedResponse response = await request.send();
      final String body = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        return const Right('Journal added successfully');
      } else {
        return Left('Failed to add journal: $body');
      }
    } catch (e) {
      return Left('Failed to add journal: ${e.toString()}');
    }
  }

   Future<List<JournalResponseModel>> getListJournal() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/journal/');
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
      return data.map((e) => JournalResponseModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

   Future<JournalResponseModel> getDetailJournalId(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/journal/$id');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return JournalResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
