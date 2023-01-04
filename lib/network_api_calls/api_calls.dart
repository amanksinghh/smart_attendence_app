import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../api_models/user_put_location_response.dart';
import '../pages/root_app.dart';

class ApiCalls{
  Data? putResponseData;


  putLatLong(BuildContext context,Position? position, String? formattedDate, String? authToken) async {
    //&& userById?.orgLatitude == position?.latitude  && userById?.orgLongitude == position?.longitude

    if (position?.latitude != null) {
      Map data = {
        "currLat": position?.latitude.toString(),
        "currLong": position?.longitude.toString(),
        "entry": formattedDate,
        "exit": formattedDate
      };
      //encode Map to JSON
      String body = json.encode(data);
      var url = 'https://attandance-server.onrender.com/user/${authToken}';
      Response response = await http.put(
        Uri.parse(url),
        body: body,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var userPutResponse =
        UserPutLocationResponse.fromJson(json.decode(response.body));
        if (userPutResponse.status == true) {
          var userDetails = userPutResponse.data!;
          putResponseData = userDetails;
          print(putResponseData?.designation);

          Fluttertoast.showToast(
              msg: "Punched In Successfully.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => RootApp(pageIndex: 4)
            ),
                (route) => false,
          );
        } else {
          Fluttertoast.showToast(
              msg: "${userPutResponse.status} : Please try again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: "${response.statusCode} : Please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "You are Outside of Organisation ! Cannot Punch In. ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}