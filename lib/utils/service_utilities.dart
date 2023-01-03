import 'dart:io';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';

import '../dialogs/CustomProgressDialog.dart';
import '../face_auth_puch/punch_in.dart';

class ServiceUtils {
  bool isDialogShowing = false;

  /*
    Show error message
   */
  static showErrorMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade600,
      elevation: 0,
      duration: const Duration(seconds: 3),
    ));
  }

  /*
    Show success message
   */
  static showSuccessMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      duration: const Duration(seconds: 3),
    ));
  }

  showLoader(BuildContext context) {
    if (!isDialogShowing) {
      isDialogShowing = true;
      showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return const CustomProgressDialog();
          }).then((value) {
        isDialogShowing = false;
      });
    }
  }

  hideLoader(BuildContext context) {
    if (isDialogShowing) {
      Navigator.pop(context);
    }
  }


  showLogoutPopup(BuildContext context, Function onLogout) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Logout",
              style: TextStyle(
                  fontSize: 16, color: Colors.black),
            ),
            // To display the title it is optional
            content: Text(
              "Are you sure",
              style: TextStyle(
                  fontSize: 14, color: Colors.black),
            ),
            // Message which will be pop up on the screen
            // Action widget which will provide the user to acknowledge the choice
            actions: [
              TextButton(
                // FlatButton widget is used to make a text to work like a button
                onPressed: () {
                  Navigator.pop(context);
                },
                // function used to perform after pressing the button
                child: Text(
                  "No",
                  style:
                      TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  onLogout();
                },
                child: Text(
                  "Yes",
                  style:
                      TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          );
        });
  }
}
