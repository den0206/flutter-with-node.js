import 'dart:convert';

import 'package:client_side/src/service/auth_service.dart';
import 'package:http/http.dart' as http;

import 'package:client_side/src/api/enviroment.dart';
import 'package:client_side/src/model/response.dart';
import 'package:client_side/src/model/user.dart';

class UserAPI {
  String _url = Enviroment.host;
  String _api = "/api/users";

  String? get token {
    final user = AuthService.to.user;
    if (user == null || user.sessionToken == null) {
      return null;
    }

    return "JWT ${user.sessionToken}";
  }

  Future<ResponseAPI?> create(Map<String, dynamic> user) async {
    try {
      Uri uri = Uri.http(_url, "$_api/create");
      String bodyParams = json.encode(user);
      Map<String, String> headers = {"Content-type": "application/json"};

      final res = await http.post(uri, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      print(data);

      ResponseAPI responseAPI = ResponseAPI.fromMap(data);
      return responseAPI;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ResponseAPI?> login(String email, String password) async {
    try {
      Uri uri = Uri.http(_url, "$_api/login");
      final paramas = {"email": email, "password": password};
      final body = json.encode(paramas);
      Map<String, String> headers = {"Content-type": "application/json"};

      final res = await http.post(uri, headers: headers, body: body);
      final data = json.decode(res.body);

      print(data);
      ResponseAPI responseAPI = ResponseAPI.fromMap(data);

      return responseAPI;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> getById(String id) async {
    try {
      if (token == null) {
        throw "No Token";
      }
      Uri uri = Uri.http(_url, "$_api/findById/$id");
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": token!,
      };

      final res = await http.get(uri, headers: headers);

      final data = json.decode(res.body);
      print(data);
      final user = User.fromJson(data);

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ResponseAPI?> update(Map<String, dynamic> user) async {
    try {
      if (token == null) {
        throw "No Token";
      }
      Uri uri = Uri.http(_url, "$_api/update");
      String bodyParams = json.encode(user);
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": token!,
      };

      final res = await http.put(uri, headers: headers, body: bodyParams);
      print("Call");

      final data = json.decode(res.body);
      print(data);
      ResponseAPI responseAPI = ResponseAPI.fromMap(data);

      return responseAPI;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ResponseAPI?> logout(String id) async {
    try {
      Uri uri = Uri.http(_url, "$_api/logout");
      final paramas = {"id": id};
      final body = json.encode(paramas);
      Map<String, String> headers = {
        "Content-type": "application/json",
      };

      final res = await http.post(uri, body: body, headers: headers);
      final data = json.decode(res.body);

      print(data);
      ResponseAPI responseAPI = ResponseAPI.fromMap(data);

      return responseAPI;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
