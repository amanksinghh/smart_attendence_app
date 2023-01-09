import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:smart_attendence_app/utils/service_utilities.dart';

import '../../api_models/responses/cafe_all_items_response.dart';
import '../../theme/colors.dart';


class MenuCards extends StatefulWidget {
  const MenuCards({Key? key}) : super(key: key);

  @override
  State<MenuCards> createState() => _MenuCardsState();
}

class _MenuCardsState extends State<MenuCards> {

  List<Items>? cafeItems;

  getCafeItems() async {
    var url = 'https://attandance-server.onrender.com/cafe/items';
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        var cafeListResponse =
        CafeItemResponse.fromJson(json.decode(response.body));
        var cafeItem = cafeListResponse.items;
        cafeItems = cafeItem;
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
    Widget build(BuildContext context) {
      getCafeItems();
      return Scaffold(
        body: SafeArea(
            child: ListView.builder(
              itemCount: cafeItems?.length,
              itemBuilder: (context, position) {
                return Card(
                  elevation: 8,
                  color: white,
                  borderOnForeground: true,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ServiceUtils().menuItems(
                          position+1,
                          cafeItems
                              ?.elementAt(position)
                              .itemName ?? "--",
                          cafeItems
                              ?.elementAt(position)
                              .itemPrice
                              .toString() ??
                              "--")),
                );
              },
            )),
      );
    }
  }
