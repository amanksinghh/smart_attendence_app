import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../api_models/user_response.dart';
import 'api_constants.dart';

class ApiService {
  Future<List<UsersResponseModel>> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<UsersResponseModel> _model = UsersResponseModel.fromJson(jsonDecode(response.body)) as List<UsersResponseModel> ;
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    throw "Not called";
  }
}