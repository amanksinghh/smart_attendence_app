import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendence_app/utils/service_utilities.dart';

import '../../api_models/responses/user_by_id_response.dart';
import '../../theme/colors.dart';

class LeavesCards extends StatefulWidget {
  const LeavesCards({Key? key}) : super(key: key);

  @override
  State<LeavesCards> createState() => _LeavesCardsState();
}

class _LeavesCardsState extends State<LeavesCards> {
  String? authToken;
  Users? userById;
  late List<MyLeaves>? myLeaves = [];

  _getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("authToken");
    await _getMyLeaves();
  }

  _getMyLeaves() async {
    var url = 'https://attandance-server.onrender.com/user';
    Response response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $authToken',
    });
    if (response.statusCode == 200) {
      var userListResponse =
          UserByIdResponse.fromJson(json.decode(response.body));
      var userDetails = userListResponse.users;
      userById = userDetails;
      setState(() {
        myLeaves = userDetails?.myLeaves!;
      });
    } else {
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
    super.initState();
    _getUserToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: myLeaves!.length,
          itemBuilder: (context, position) {
            return Card(
              elevation: 8,
              color: white,
              borderOnForeground: true,
              child: ServiceUtils().leavesContainer(
                context,
                myLeaves!.elementAt(position).from!,
                myLeaves!.elementAt(position).to!,
                myLeaves!.elementAt(position).reason!,
                myLeaves!.elementAt(position).leaveType!,
                myLeaves!.elementAt(position).leaveStatus.toString(),
                myLeaves!.elementAt(position).leaveStatus!,
              ),
            );
          },
        ),
      ),
    );
  }
}
