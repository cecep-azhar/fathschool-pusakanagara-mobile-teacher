import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/data/models/response/auth_response_model.dart';
import 'package:fath_school/data/models/response/forgot_password_response_model.dart';
import 'package:fath_school/data/models/response/setting_mobile_response_model.dart';
import 'package:fath_school/data/models/response/student_details_response_model.dart';
import 'package:fath_school/data/models/response/user_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String username, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userRole = data['user']['role'];

      if (userRole != 'Teacher' &&
          userRole != 'Administration' &&
          userRole != 'Tata Usaha') {
        return Left('Role Anda sebagai "$userRole" tidak memiliki akses');
      }

      final authData = AuthResponseModel.fromJson(response.body);
      await AuthLocalDatasource().saveAuthData(authData);
      return Right(authData);
    } else {
      return const Left('Login gagal');
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      await AuthLocalDatasource().removeAuthData();
      return const Right('Logout success');
    } else {
      return const Left('Failed to logout');
    }
  }

  Future<Either<String, UserResponseModel>> updateProfileRegisterFace(
    String embedding,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/update-face');
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer ${authData?.token}'
      ..fields['face_embedding'] = embedding;

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return Right(UserResponseModel.fromJson(responseString));
    } else {
      return const Left('Failed to update profile');
    }
  }

  Future<void> updateFcmToken(String fcmToken) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/update-fcm-token');
    await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: jsonEncode({
        'fcm_token': fcmToken,
      }),
    );
  }

  Future<Either<String, ForgotPasswordResponseModel>> forgotPassword(
      String phone) async {
    final url = Uri.parse('${Variables.baseUrl}/api/forgot-password');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'phone': phone,
      }),
    );

    if (response.statusCode == 200) {
      final forgotPasswordResponse =
          ForgotPasswordResponseModel.fromJson(response.body);
      return Right(forgotPasswordResponse);
    } else {
      return const Left('Failed to Forgot Password');
    }
  }

  Future<Either<String, ForgotPasswordResponseModel>> forgetPassword(
      String password, String passwordConfirmation) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/forget-password');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: jsonEncode({
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 200) {
      final forgotPasswordResponse =
          ForgotPasswordResponseModel.fromJson(response.body);
      return Right(forgotPasswordResponse);
    } else {
      return const Left('Failed to Forgot Password');
    }
  }

  Future<StudentDetailsResponseModel> getUserById(int userId) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/user/$userId');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return StudentDetailsResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // Future<void> getId(int userId) async {
  //   final authData = await AuthLocalDatasource().getAuthData();
  //   final url = Uri.parse('${Variables.baseUrl}/api/userid');
  //   await http.post(
  //     url,
  //     headers: {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${authData?.token}',
  //     },
  //     body: jsonEncode({
  //       'user_id': userId,
  //     }),
  //   );
  // }

  Future<Either<String, UserResponseModel>> updateProfile(XFile? image) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/update-profile');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);
    if (image != null) {
      request.files.add(
          await http.MultipartFile.fromPath('profile_photo_path', image.path));
    }

    try {
      final http.StreamedResponse response = await request.send();

      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return Right(UserResponseModel.fromJson(responseString));
      } else {
        return Left('Failed to Update Profile: $responseString');
      }
    } catch (e) {
      return Left('Failed to Update Profile: ${e.toString()}');
    }
  }

  Future<Either<String, SettingMobileResponse>> getSettingMobile() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/mobile-settings');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      try {
        final List<dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.isNotEmpty) {
          final data = SettingMobileResponse.fromMap(
              jsonResponse[0] as Map<String, dynamic>);
          return Right(data);
        } else {
          return const Left('No data available');
        }
      } catch (e) {
        return const Left('Failed to parse settings');
      }
    } else {
      return const Left('Failed to get setting mobile');
    }
  }
}
