import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';

import '../root_app.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>
    with SingleTickerProviderStateMixin {

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

  // Future<void> _authenticate() async {
  //   bool authenticated = false;
  //   try {
  //     // ignore: deprecated_member_use
  //     authenticated = await auth.authenticate(
  //       localizedReason: "Scan your finger to authenticate",
  //     );
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //
  //   setState(() {
  //     authorized =
  //     authenticated ? "Authorized success" : "Failed to authenticate";
  //     print(authorized);
  //
  //     if (authenticated) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => RootApp(),
  //         ),
  //       );
  //     }
  //   });
  // }
  //
  // Future<void> _checkBiometric() async {
  //   bool canCheckBiometric = false;
  //
  //   try {
  //     canCheckBiometric = await auth.canCheckBiometrics;
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _canCheckBiometric = canCheckBiometric;
  //   });
  // }
  //
  // Future _getAvailableBiometric() async {
  //   List<BiometricType> availableBiometric = [];
  //
  //   try {
  //     availableBiometric = await auth.getAvailableBiometrics();
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //
  //   setState(() {
  //     _availableBiometric = availableBiometric;
  //   });
  // }

  // @override
  // void initState() {
  //   _checkBiometric();
  //   _getAvailableBiometric();
  //   _controller = AnimationController(
  //       duration: const Duration(milliseconds: 4000), vsync: this, value: 0.2);
  //   _animation =
  //       CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
  //   _controller.forward();
  //   super.initState();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:
          Container(
          child: FlutterLogin(
            title: "Welcome",
            onLogin: (_) => Future.value(),
            onSubmitAnimationCompleted: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => RootApp()));
              }, onRecoverPassword: (String ) {  },
          ),
        ),
      );
  }
}

// const SizedBox(height: 20,),
// const Text(
// "OR",
// style: TextStyle(
// color: Colors.white,
// fontSize: 18,
// decorationColor: Colors.white),
// ),
// const SizedBox(height: 20,),
// GestureDetector(
// onTap: _authenticate,
// child: Padding(
// padding: const EdgeInsets.symmetric(
// vertical: 12.0, horizontal: 24.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Container(
// margin: const EdgeInsets.only(
// top: 12.0, left: 30.0, right: 20.0),
// child: Column(
// children: [
// Image.asset(
// "assets/images/fingerprint.png",
// width: 100.0,
// ),
// ],
// ),
// )
// ],
// ),
// ),
// ),
