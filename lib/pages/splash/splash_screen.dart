import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_utils/login_page.dart';
import '../root_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({key});

  static const String id = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  String? authToken;

  void initState() {
    super.initState();
    getLoginData();
    Future.delayed(const Duration(seconds: 4), () {
      if (authToken == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  LoginPage()));
      } else {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => RootApp(pageIndex: 0,),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }

  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("authToken");
    return authToken;
  }
}
