import 'package:flutter/material.dart';
import 'package:smart_attendence_app/pages/login_utils/login_page.dart';
import 'package:smart_attendence_app/pages/root_app.dart';
import 'package:smart_attendence_app/pages/splash/splash_screen.dart';
import 'package:smart_attendence_app/services/locator.dart';

final routes = {
  '/': (context) => RootApp(pageIndex: 0,),
  '/root': (context) => RootApp(pageIndex: 0,),
  "/login": (context) => const LoginPage(),
};

void main() {
  setupServices();
  runApp(const MyApp());
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
            splashColor: const Color.fromARGB(255, 245, 112, 51),
          ),
          home: const SplashScreen()
      ),
    );
  }
}