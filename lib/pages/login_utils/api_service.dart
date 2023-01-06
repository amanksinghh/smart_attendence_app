import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<LoginApiResponse> apiCallLogin(Map<String, dynamic> params) async {
    var uri = "https://loginlogoutserverreactnative.herokuapp.com/user/login";
    var url = Uri.parse(uri);
    var response = await http.post(url, body: params);
    print('${response.statusCode}');
    print('${response.body}');

    final responseBody = jsonDecode(response.body);
    final data = jsonDecode(response.body);
    print('${data['email']}');
    print('${data['password']}');

    return LoginApiResponse(token: data['token'], error: data['error']);
  }
}

class LoginApiResponse {
  final String? token;
  final String? error;

  LoginApiResponse({this.token, this.error});
}
