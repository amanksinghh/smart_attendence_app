
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:smart_attendence_app/onboarding/onboarding_screen.dart';
import 'package:smart_attendence_app/pages/login_utils/login_page.dart';
import 'package:smart_attendence_app/pages/root_app.dart';
import 'package:smart_attendence_app/services/locator.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'utils/fingerprint_settings.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

final routes = {
  '/': (context) => RootApp(),
  '/root': (context) => RootApp(),
  "/login": (context) => LoginPage(),
};

void main() {
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My App',
          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.light,
            splashColor: Color.fromARGB(255, 245, 112, 51),
          ),
          home: AnimatedSplashScreen(
              splash: Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 1000,
                  width: 1000,
                ),
              ),
              duration: 2000, // splash screen
              nextScreen: LoginPage(),
              splashTransition: SplashTransition.scaleTransition,
              pageTransitionType: PageTransitionType.fade,
              backgroundColor: Color.fromARGB(255, 255, 254, 254))),
    );
  }
}