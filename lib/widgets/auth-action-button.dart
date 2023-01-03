import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendence_app/pages/root_app.dart';
import '../api_models/user_by_id_response.dart';
import '../api_models/user_put_location_response.dart';
import '../db/databse_helper.dart';
import '../db/user.model.dart';
import '../pages/homepage/homepage.dart';
import '../pages/profile.dart';
import '../services/camera.service.dart';
import '../services/locator.dart';
import '../services/ml_service.dart';
import '../utils/shared_pref.dart';
import 'app_button.dart';
import 'app_text_field.dart';
import 'package:http/http.dart' as http;

class AuthActionButton extends StatefulWidget {
  AuthActionButton(
      {Key? key,
      required this.onPressed,
      required this.isLogin,
      required this.reload});
  final Function onPressed;
  final bool isLogin;
  final Function reload;
  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  final MLService _mlService = locator<MLService>();
  final CameraService _cameraService = locator<CameraService>();

  final TextEditingController _userTextEditingController =
      TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController =
      TextEditingController(text: '');

  User? predictedUser;

  DateTime? date;
  final amount = TextEditingController();

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  Position? position;
  String? long , lat ;
  late StreamSubscription<Position> positionStream;
  String? formattedDate;
  late bool mounted;
  String? authToken;
 // Users? users;
  Users? userById;
  Data? putResponseData;

  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("authToken");
    print(authToken);
    getUsers();
    return authToken;
  }

  Future<void> getUsers() async {
    var url = 'https://attandance-server.onrender.com/user/${authToken}';
    Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var userListResponse = UserByIdResponse.fromJson(json.decode(response.body));
      var userDetails = userListResponse.users;
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

  Future<void> putLatLong() async {
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RootApp(pageIndex: 4)));
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

  Future _signUp(context) async {
    DatabaseHelper _databaseHelper = DatabaseHelper.instance;
    List predictedData = _mlService.predictedData;
    String user = _userTextEditingController.text;
    String password = amount.text;
    User userToSave = User(
      user: user,
      password: password,
      modelData: predictedData,
    );
    await _databaseHelper.insert(userToSave);
    this._mlService.setPredictedData([]);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RootApp(pageIndex: 0,)));
  }

  Future _signIn(context) async {
    String password = _passwordTextEditingController.text;
    if (this.predictedUser!.password == password) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Profile(
                    this.predictedUser!.user,
                    imagePath: _cameraService.imagePath!,
                  )));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Wrong password!'),
          );
        },
      );
    }
  }

  Future<User?> _predictUser() async {
    User? userAndPass = await _mlService.predict();
    return userAndPass;
  }

  Future onTap() async {
    try {
      bool faceDetected = await widget.onPressed();
      if (faceDetected) {
        if (widget.isLogin) {
          var user = await _predictUser();
          if (user != null) {
            this.predictedUser = user;
          }
        }
        getLocation();
        setState(
              () {
            date = DateTime.now();
            formattedDate = DateFormat.Hm().format(date!);
            amount.text = '$date';
            getLocation();
            getLoginData();
          },
        );
        PersistentBottomSheetController bottomSheetController =
            Scaffold.of(context)
                .showBottomSheet((context) => signSheet(context));
        bottomSheetController.closed.whenComplete(() => widget.reload());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[200],
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CAPTURE',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.camera_alt, color: Colors.white)
          ],
        ),
      ),
    );
  }

  signSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isLogin && predictedUser != null
              ? Container(
                  child: Text(
                    'Welcome back, ${predictedUser!.user}.',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : widget.isLogin
                  ? Container(
                      child: Text(
                      'User not found 😞',
                      style: TextStyle(fontSize: 20),
                    ))
                  : Container(),
          Container(
            child: Column(
              children: [
                !widget.isLogin
                    ? Text(
                      "LAT: ${position?.latitude}, LNG: ${position?.longitude}"
                      )
                    : Container(),
                SizedBox(height: 10),
                widget.isLogin && predictedUser == null
                    ? Container()
                    : Text(
                          "Entry Time: ${formattedDate}",
                      ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                widget.isLogin && predictedUser != null
                    ? AppButton(
                        text: 'LOGIN',
                        onPressed: () async {
                          _signIn(context);
                        },
                        icon: Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                      )
                    : !widget.isLogin
                        ? AppButton(
                            text: 'Punch In',
                            onPressed: () {
                              //await _signUp(context);
                              putLatLong();
                            },
                            icon: Icon(
                              Icons.person_add,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission not granted");
      Geolocator.requestPermission();
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print(position!.latitude.toString());
      print(position!.longitude.toString());
    }
  }
}
