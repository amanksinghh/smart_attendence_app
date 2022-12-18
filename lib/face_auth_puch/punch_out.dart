import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../api_models/user_put_location_response.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../api_models/user_response.dart';
import '../pages/root_app.dart';
import '../services/camera.service.dart';
import '../services/face_detector_service.dart';
import '../services/locator.dart';
import '../services/ml_service.dart';
import '../widgets/FacePainter.dart';
import '../widgets/auth-action-button.dart';
import '../widgets/camera_header.dart';
import 'package:http/http.dart' as http;


class PunchOut extends StatefulWidget {
  const PunchOut({Key? key}) : super(key: key);

  @override
  PunchOutState createState() => PunchOutState();
}

class PunchOutState extends State<PunchOut> {

  Users? userById;
  Data? putResponseData;
  String? formattedDate;
  String? formattedTime;
  DateTime? date;

  Future<void> putLatLong() async {

    Map data = {
      "exit": formattedTime
    };
    //encode Map to JSON
    String body = json.encode(data);
    var url = 'https://attandance-server.onrender.com/user/639c00a212b97a003403fd31';
    Response response = await http.put(
      Uri.parse(url),body: body,headers: {
      "Content-Type": "application/json"
    },
    );
    if(response.statusCode == 200){
      var userPutResponse = UserPutLocationResponse.fromJson(json.decode(response.body));
      if(userPutResponse.status == true)
      {
        var userDetails = userPutResponse.data!;
        putResponseData = userDetails;
        print(putResponseData?.designation);

        Fluttertoast.showToast(
            msg: "Punched Out Successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pop(context);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "${userPutResponse.status} : Please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    }
    else {
      Fluttertoast.showToast(
          msg: "Something went wrong. Try again !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      date = DateTime.now();
      formattedTime = DateFormat.Hm().format(date!);
      formattedDate = DateFormat.MMMd().format(date!);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Punch Out"),
      ),
        body: Center(
          child: MaterialButton(
            onPressed: () { putLatLong(); },
            child: Text("Confirm Punch Out"),
            height: 50,
            minWidth: 100,
            color: Colors.blue,
            textColor: Colors.white,
          ),
        )
    );
  }
}
