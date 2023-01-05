import 'package:flutter/material.dart';

class CustomProgressDialog extends StatefulWidget {
  final Function? ontap;

  const CustomProgressDialog({Key? key, this.ontap}) : super(key: key);

  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<CustomProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      height: MediaQuery.of(context).size.height,
      width: 50.0,
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: Colors.blue),
    );
  }
}
