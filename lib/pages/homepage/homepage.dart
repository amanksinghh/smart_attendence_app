import 'dart:convert';

import "package:flutter/material.dart";
import 'package:smart_attendence_app/api_models/user_response.dart';

import '../../network_api_calls/api_constants.dart';
import '../../network_api_calls/api_service.dart';
import 'dart:developer';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<UsersResponseModel> _userModel =[];
        List<Users>? users;

  Future<List<UsersResponseModel>> _getData() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl);
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        List responseJson = jsonDecode(response.body.toString());
       //List<UsersResponseModel> _model = responseJson;
       // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    throw "Not called";
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
      ),

      body: _userModel == null || _userModel!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: _userModel!.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_userModel![index].users.toString()),
                   // Text(_userModel![index].username),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Text(_userModel![index].email),
                    // Text(_userModel![index].website),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

