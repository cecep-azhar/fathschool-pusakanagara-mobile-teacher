import 'package:dartz/dartz.dart';
import 'package:fath_school/data/models/response/mobile_notification_response_model.dart';
import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;

class MobileNotificationRemoteDatasource {
  Future<Either<String, MobileNotificationResponseModel>> getMobileNotification() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/mobile-notifications'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData?.token}',
        },
      );
      if (response.statusCode == 200) {
        return Right(MobileNotificationResponseModel.fromJson(response.body));
      } else {
        return const Left('Failed to get mobile notification');
      }
      // return Right(MobileNotificationResponseModel(
      //   status: 'success',
      //   data: [
      //     Datum(
      //       id: 1,
      //       title: 'Pengumuman',
      //       message: 'Pengumuman terbaru',
      //       token: 'token',
      //       status: 'unread',
      //       sendAt: '2021-09-01 00:00:00',
      //       createdAt: DateTime.now(),
      //       updatedAt: DateTime.now(),
      //     ),
      //     Datum(
      //       id: 2,
      //       title: 'Pengumuman',
      //       message: 'Pengumuman terbaru',
      //       token: 'token',
      //       status: 'unread',
      //       sendAt: '2021-09-01 00:00:00',
      //       createdAt: DateTime.now(),
      //       updatedAt: DateTime.now(),
      //     ),
      //     Datum(
      //       id: 3,
      //       title: 'Pengumuman',
      //       message: 'Pengumuman terbaru',
      //       token: 'token',
      //       status: 'unread',
      //       sendAt: '2021-09-01 00:00:00',
      //       createdAt: DateTime.now(),
      //       updatedAt: DateTime.now(),
      //     ),
      //     Datum(
      //       id: 4,
      //       title: 'Pengumuman',
      //       message: 'Pengumuman terbaru',
      //       token: 'token',
      //       status: 'unread',
      //       sendAt: '2021-09-01 00:00:00',
      //       createdAt: DateTime.now(),
      //       updatedAt: DateTime.now(),
      //     ),
      //     Datum(
      //       id: 5,
      //       title: 'Pengumuman',
      //       message: 'Pengumuman terbaru',
      //       token: 'token',
      //       status: 'unread',
      //       sendAt: '2021-09-01 00:00:00',
      //       createdAt: DateTime.now(),
      //       updatedAt: DateTime.now(),
      //     ),
      //   ],
      // ));
    } catch (e) {
      return Left('Failed to get mobile notification: ${e.toString()}');
    }
}}