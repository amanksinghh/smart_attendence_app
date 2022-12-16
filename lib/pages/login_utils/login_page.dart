// ignore_for_file: avoid_unnecessary_containers, prefer
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'package:smart_attendence_app/api_models/user_response.dart';
import 'package:smart_attendence_app/pages/homepage/homepage.dart';
import 'package:flutter_login/flutter_login.dart';

import '../../api_models/user_login.dart';
import '../root_app.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  //Animation Settings
  late AnimationController _controller;
  late Animation<double> _animation;

  bool loading = false;

  //Text Field Settings

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool success = false;

  final _formKey = GlobalKey<FormState>();
  //FingerPrint Settings
  final auth = LocalAuthentication();
  String authorized = " Not authorized";
  bool _canCheckBiometric = false;
  late List<BiometricType> _availableBiometric;
  List<Data>? userData;
  late Data _data;

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      // ignore: deprecated_member_use
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger to authenticate",
      );
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      authorized =
          authenticated ? "Authorized success" : "Failed to authenticate";
      print(authorized);

      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RootApp(),
          ),
        );
      }
    });
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  ///Login Functionality
  Future<void> login() async {

    Map data = {
      "email": emailController.text,
      "password" : passwordController.text
    };
    //encode Map to JSON
    String body = json.encode(data);
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var url = 'https://attandance-server.onrender.com/user/login';
      Response response = await http.post(
         Uri.parse(url),body: body,headers: {
        "Content-Type": "application/json"
      },
      );
      if(response.statusCode == 200){
        var userLoginResponse = UserLoginResponse.fromJson(json.decode(response.body));
        if(userLoginResponse.status == "SUCCESS")
          {
            var userDetails = userLoginResponse.data!;
            _data = userDetails.first;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${_data.fullName} : ${userLoginResponse.message}"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
                dismissDirection: DismissDirection.down,
                elevation: 10,
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RootApp(),
              ),
            );
          }
        else
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${userLoginResponse.message}"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
                dismissDirection: DismissDirection.down,
                elevation: 10,
              ),
            );
          }
      }
      else if(response.statusCode != 200){
        print(response.statusCode);
        print('Something went wrong!');
      }
     else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter your email and password"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          dismissDirection: DismissDirection.down,
          elevation: 10,
        ),
      );
    }}
  }

  @override
  void initState() {
    //FingerPrint
    _checkBiometric();
    _getAvailableBiometric();
    //Animations'
    _controller = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this, value: 0.2);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage("assets/images/aimtron_building.jpg"),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black87,
          ),
          Center(
            // ignore: unnecessary_new
            child: new Theme(
              data: ThemeData(
                  brightness: Brightness.dark,
                  inputDecorationTheme: InputDecorationTheme(
                    // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 70, 96, 241),
                        fontSize: 18.0),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ignore: prefer_const_constructors
                    Container(
                      child: new ScaleTransition(
                        scale: _animation,
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                          height: 300,
                          width: 250,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(25.0),
                      // ignore: unnecessary_new
                      child: new Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: "Enter Email",
                                  hintText: "Enter  Email",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: success
                                          ? Colors.green
                                          : Color.fromARGB(255, 240, 120, 84),
                                      width: 2.0,
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.person),
                                  fillColor: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: "Enter Password",
                                  prefixIcon: Icon(Icons.lock),
                                  fillColor: Colors.white,
                                  hintText: "Password",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: success
                                          ? Colors.green
                                          : Color.fromARGB(255, 240, 120, 84),
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                obscureText: true,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                            ),
                            MaterialButton(
                              onPressed: () {
                                login();
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                              },
                              child: Text("Login"),
                              color: Color.fromARGB(255, 240, 96, 30),
                              textColor: Colors.white,
                              elevation: 50,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              splashColor:
                                  const Color.fromARGB(255, 34, 65, 241),
                              height: 40,
                              minWidth: 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  decorationColor: Colors.white),
                            ),
                            GestureDetector(
                              onTap: _authenticate,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 12.0, left: 30.0, right: 20.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/fingerprint.png",
                                            width: 100.0,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
