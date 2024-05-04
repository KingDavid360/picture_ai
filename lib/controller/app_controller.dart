import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart' as getx;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:picture_ai/model/data_model.dart';

import '../api_route.dart';
import '../network.dart';

class AppController extends GetxController {
  //upload photo controller
  Future<bool> uploadPhoto(File? image) async {
    MultipartFile productImage;

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    // Map<String, dynamic> noMediaReq = {}..addAll(val);
    productImage = await MultipartFile.fromFile(
      image!.path,
      filename: '$id/${image}',
    );
    FormData formData = FormData.fromMap({
      'file': productImage,
    });
    log("FD =>${formData.fields}");
    print("MultipartFile Info => ${productImage}");
    try {
      var res = await ApiClient()
          .postImage(formData: formData, routeUrl: ApiRoute.uploadPhoto);
      log("image response || $res");
      print(res.statusCode);
      // log(res);

      return true;
    } on DioException catch (e, s) {
      log('e=>$e');
      log('s=.>$s');
      return false;
    } catch (e) {
      print("error: $e");
      return false;
    }
  }

  //fetch data controller
  DataModel? dataModel;
  Future<bool> fetchUsers() async {
    try {
      var responseBody = await ApiClient().getData(ApiRoute.getInfo);
      dataModel = dataModelFromJson(responseBody.body);
      log("data  || ${responseBody.body}");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // delete info controller
  Future<bool> deleteInfo(String id) async {
    try {
      var responseBody =
          await ApiClient().deleteData(id, "${ApiRoute.deleteInfo}/$id");
      final response = jsonDecode(responseBody.body);
      log("delete response || ${responseBody.body}");
      print(responseBody.statusCode);
      if (responseBody.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("verify passcode Error=> $e");
      return false;
    }
  }
}
