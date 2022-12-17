import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart';
import 'package:smart_attendence_app/api_models/user_response.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Users? users;

  Future<void> getUsers() async {
      var url = 'https://attandance-server.onrender.com/user';
      Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var userListResponse = UsersResponseModel.fromJson(json.decode(response.body));
        var userDetails = userListResponse.users;
        users = userDetails!.first;
        print(users?.fullName);
        print("API called");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${users?.fullName} : ${users?.email}"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
            dismissDirection: DismissDirection.down,
            elevation: 10,
          ),
        );
      }
      else
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Something went wrong !"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
              dismissDirection: DismissDirection.down,
              elevation: 10,
            ),
          );
        }
  }
  @override
  void initState() {
    getUsers();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Users List"),
      ),

      body:  SingleChildScrollView(
        child:
        Column(
          children: [
            Text(users?.fullName ?? ""),
            const SizedBox(
              height: 20.0,
            ),
          ]
        )
      )
    );
  }
}

