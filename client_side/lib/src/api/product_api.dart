import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client_side/src/api/enviroment.dart';
import 'package:client_side/src/model/response.dart';
import 'package:client_side/src/service/auth_service.dart';

class ProductAPI {
  String _url = Enviroment.host;
  String _endPoint = '/api/product';

  String? get token {
    final user = AuthService.to.user;
    if (user == null || user.sessionToken == null) {
      return null;
    }

    return "JWT ${user.sessionToken}";
  }

  Future<ResponseAPI?> create(Map<String, dynamic> product) async {
    try {
      Uri uri = Uri.http(_url, "$_endPoint/create");
      String bodyParams = json.encode(product);
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": token!,
      };

      // final request = await http.MultipartRequest("POST", uri);
      final request = await http.post(uri, headers: headers, body: bodyParams);
      final data = json.decode(request.body);

      print(data);

      ResponseAPI responseAPI = ResponseAPI.fromMap(data);
      return responseAPI;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
