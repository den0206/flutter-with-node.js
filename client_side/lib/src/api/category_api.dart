import 'dart:convert';

import 'package:client_side/src/api/enviroment.dart';
import 'package:client_side/src/model/response.dart';
import 'package:http/http.dart' as http;

import 'package:client_side/src/service/auth_service.dart';

class CategoryAPI {
  String _url = Enviroment.host;
  String _api = "/api/category";

  String? get token {
    final user = AuthService.to.user;
    if (user == null || user.sessionToken == null) {
      return null;
    }

    return "JWT ${user.sessionToken}";
  }

  Future<ResponseAPI?> create(Map<String, dynamic> category) async {
    try {
      if (token == null) {
        throw "No Token";
      }
      Uri uri = Uri.http(_url, "$_api/create");
      String bodyParams = json.encode(category);

      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": token!,
      };

      final res = await http.post(uri, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        print("No Auth");
      }
      final data = json.decode(res.body);

      ResponseAPI responseAPI = ResponseAPI.fromMap(data);
      print(responseAPI);

      return responseAPI;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
