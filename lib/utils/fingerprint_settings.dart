import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FingerprintAuth extends StatefulWidget {
  const FingerprintAuth({Key? key}) : super(key: key);

  @override
  _FingerprintAuthState createState() => _FingerprintAuthState();

  static authenticate() {}
}

class _FingerprintAuthState extends State<FingerprintAuth> {
  final auth = LocalAuthentication();
  String authorized = " Not authorized";
  bool _canCheckBiometric = false;
  late List<BiometricType> _availableBiometric;

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
    });
    if (authenticated) {
      Navigator.pushNamed(context, '/homepage');
    }
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

  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometric();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Fingerprint Auth")),
      // backgroundColor: Color(0xFF3C3E52),
      body: GestureDetector(
        onTap: _authenticate,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.0, left: 150.0, right: 12.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/fingerprint.png",
                      width: 120.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
