import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as https;

class ApiClient {
  static const String baseUrl =
      'https://liver-disease-prediction-backend-1.onrender.com';
  ApiClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: "https://p0vl14mk-3000.uks1.devtunnels.ms/api/v1/",
                connectTimeout: const Duration(seconds: 15),
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
              ),
            );
  final Dio _dio;

  //Get data method
  getData(routeUrl) async {
    var url = Uri.parse('$baseUrl/$routeUrl');
    var response = await https.get(url, headers: {
      'Content-type': 'application/json',
    });
    return response;
  }

  //uploading image method
  Future<dynamic> postImage({FormData? formData, String? routeUrl}) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/$routeUrl',
        data: formData,
        options: Options(
          method: 'POST',
          contentType: 'application/json',
          headers: {},
          responseType: ResponseType.plain,
        ),
      );
      return response;
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      print("here");
      print("response ");
      rethrow;
    }
  }

  //delete data method
  deleteData(data, routeUrl) async {
    var client = https.Client();
    var url = Uri.parse('$baseUrl/$routeUrl');
    var response =
        await client.delete(url, headers: {}, body: jsonEncode(data));
    return response;
  }
}
