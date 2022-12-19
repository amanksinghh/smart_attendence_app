import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:http/http.dart';

import '../../api_models/user_by_id_response.dart';
import '../../json/daily_json.dart';
import '../../json/day_month.dart';
import '../../theme/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeDay = 3;
  TextEditingController searchController = TextEditingController();
  bool searchbarVisible = false;
  String? formattedDate;
  DateTime? date;

  Users? userById;

  Future<void> getUsers() async {
    var url = 'https://attandance-server.onrender.com/user/639c00a212b97a003403fd31';
    Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){

      setState(() {
        var userListResponse = UserByIdResponse.fromJson(json.decode(response.body));
        var userDetails = userListResponse.users;
        userById = userDetails;
        print("User by ID API called");
        print(userById?.entry);
      });

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
    super.initState();
    setState(() {
      date = DateTime.now();
      formattedDate = DateFormat.MMMd().format(date!);
      getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    getUsers();
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Attendence Summary",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Expanded(
                        child: Visibility(
                            visible: searchbarVisible,
                            child: Stack(children: [
                              Container(
                                height: 29,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 10,left: 10),
                                child: Material(
                                  borderRadius: BorderRadius.circular(5),
                                  elevation: 0,
                                  child: TextFormField(
                                    autofocus: true,
                                    // focusNode: searchbarFocus,
                                    controller: searchController,
                                    onChanged: (value) {
                                      setState(() {

                                        searchController.text
                                            .split(" ")
                                            .first
                                            .trim();
                                        searchController.text
                                            .split(" ")
                                            .last
                                            .trim();
                                      });
                                    },
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(8),
                                        isDense: true,
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 4,
                                  child: Container(
                                      height: 12,
                                      width: 12,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: grey),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            searchbarVisible = false;
                                            searchController.text="";
                                            searchController.text.split(" ").first.trim();
                                            searchController.text.split(" ").last.trim();
                                          });
                                        },
                                        alignment: Alignment.center,
                                        icon: const Icon(
                                          Icons.close,
                                          size: 10,
                                        ),
                                        color: white,

                                      )))
                            ])),
                      ),
                      Visibility(
                        visible: !searchbarVisible,
                        child: IconButton(
                            onPressed: () {
                              if (searchbarVisible == false) {
                                setState(() {
                                  searchbarVisible = true;
                                });
                              } else {
                                setState(() {
                                  searchbarVisible = false;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(days.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              activeDay = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 40) / 7,
                            child: Column(
                              children: [
                                Text(
                                  days[index]['label'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: activeDay == index
                                          ? primary
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: activeDay == index
                                              ? primary
                                              : black.withOpacity(0.1))),
                                  child: Center(
                                    child: Text(
                                      days[index]['day'],
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: activeDay == index
                                              ? white
                                              : black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child:
            Container(
              margin: EdgeInsets.only(left: 6, right: 6),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(
                          formattedDate.toString(),
                          style: TextStyle(
                            fontFamily: "NexaBold",
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Punch In",
                          style: TextStyle(
                            fontFamily: "NexaRegular",
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          userById?.entry ?? "--/--",
                          style: TextStyle(
                            fontFamily: "NexaBold",
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Punch Out",
                          style: TextStyle(
                            fontFamily: "NexaRegular",
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          userById?.exit ?? "--/--",
                          style: TextStyle(
                            fontFamily: "NexaBold",
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
