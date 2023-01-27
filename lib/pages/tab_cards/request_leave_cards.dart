import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendence_app/api_models/responses/user_by_id_response.dart';
import 'package:smart_attendence_app/pages/root_app.dart';
import 'package:smart_attendence_app/pages/tab_cards/leaves_cards.dart';

import '../login_utils/login_page.dart';

class RequestLeaveCards extends StatefulWidget {
  const RequestLeaveCards({Key? key}) : super(key: key);

  @override
  State<RequestLeaveCards> createState() => _RequestLeaveCardsState();
}

class _RequestLeaveCardsState extends State<RequestLeaveCards> {
  _RequestLeaveCardsState() {
    _leaveType = _leaveTypeList[0];
  }
  late DateTime targetMonth, initialDate;
  late String month, year;
  String? formattedDated;
  int noOfDaysCurrentMonth = 0;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController leaveReasonController = TextEditingController();
  // TextEditingController leaveTypeController = TextEditingController();

  String? authToken;
  Users? userById;
  late MyLeaves myLeaves = MyLeaves();
  String? _leaveType = "";
  final _leaveTypeList = ["Unpaid", "Paid"];
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? checkDateValidator(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return "Please input Date";
    }
    return null;
  }
  String? reasonValidator(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return "Please input Reason";
    }
    return null;
  }


  getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("authToken");
    onSuccessButton();
    return authToken;
  }
   Future onSuccessButton() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        String url = "https://attandance-server.onrender.com/user/leaves";
        Map data = {
          "myLeaves":{
            'leaveType': _leaveType!,
            'from': fromDateController.text.trim(),
            'to': toDateController.text.trim(),
            'reason': leaveReasonController.text.trim()
          }
        };
        String body = json.encode(data);
        final http.Response response = await http.post(
          Uri.parse(url),
          body: body,
          headers: <String , String>{
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json; charset=UTF-8',

          },
        );
    if (response.statusCode == 200){
      String jsonData= response.body;
        _isLoading = false;
      print("Status:${response.statusCode}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LeavesCards(),
        ),
      );
      print(response.statusCode);
      Fluttertoast.showToast(
          msg: "Leave request pending",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
       return MyLeaves.fromJson(json.decode(jsonData));
    }
        else {
          _isLoading=false;
          print("Status:${response.statusCode}");
          Fluttertoast.showToast(
              msg: "Invalid Leave request",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          throw Exception('Failed to create leaves');

        }
      }catch (err) {
        print(err);
        setState(() {

        });
        rethrow;
      }
    }
  }
  @override
  void initState() {
    super.initState();
    getUserToken();
    _isLoading= false;
    targetMonth = DateTime.now();
    initialDate = DateTime.now();
    formattedDated = DateFormat.yMd().format(initialDate);
  }

  @override
  void dispose(){
    super.dispose();
    setState(() {
      fromDateController.dispose();
      toDateController.dispose();
      leaveReasonController.dispose();
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (authToken == "") {
      Timer(const Duration(milliseconds: 1), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserToken();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          // ignore: unnecessary_new
          child: new Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: fromDateController,
                  validator: checkDateValidator,
                  decoration: InputDecoration(
                      labelText: "From Date",
                      hintText: "Input Date",
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 1)),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              setState(() {
                                if (pickedDate.month == DateTime.now().month) {
                                  targetMonth = DateTime(pickedDate.year,
                                      pickedDate.month, DateTime.now().day);
                                } else {
                                  targetMonth = DateTime(
                                      pickedDate.year, pickedDate.month, 1);
                                }
                                initialDate = DateTime(pickedDate.year,
                                    pickedDate.month, pickedDate.day);
                                formattedDated =
                                    DateFormat.yMd().format(initialDate);
                                fromDateController.text = formattedDated!;
                              });
                            }
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.calendar_month),
                            ],
                          ),
                        ),
                      ),
                      fillColor: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    controller: toDateController,
                    validator:checkDateValidator,
                    decoration: InputDecoration(
                      labelText: "To Date",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: initialDate,
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 1)),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              setState(() {
                                if (pickedDate.month == DateTime.now().month) {
                                  targetMonth = DateTime(pickedDate.year,
                                      pickedDate.month, DateTime.now().day);
                                } else {
                                  targetMonth = DateTime(
                                      pickedDate.year, pickedDate.month, 1);
                                }
                                initialDate = DateTime(pickedDate.year,
                                    pickedDate.month, pickedDate.day);
                                formattedDated =
                                    DateFormat.yMd().format(initialDate);
                                toDateController.text = formattedDated!;
                              });
                            }
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.calendar_month),
                            ],
                          ),
                        ),
                      ),
                      fillColor: Colors.white,
                      hintText: "Input Date",
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: DropdownButtonFormField(
                    value: _leaveType,
                    items: _leaveTypeList
                        .map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _leaveType = value!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  // TextFormField(
                  //   controller: leaveTypeController,
                  //   decoration: const InputDecoration(
                  //     labelText: "Leave Type",
                  //     prefixIcon: Icon(Icons.note),
                  //     fillColor: Colors.white,
                  //     hintText: "Enter Type",
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: Colors.blue,
                  //         width: 2.0,
                  //       ),
                  //     ),
                  //   ),
                  //   keyboardType: TextInputType.text,
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    controller: leaveReasonController,
                    validator:reasonValidator,
                    maxLines: 4,
                    minLines: 1,
                    decoration: const InputDecoration(
                      labelText: "Leave Reason",
                      prefixIcon: Icon(Icons.note_alt),
                      fillColor: Colors.white,
                      hintText: "Enter Reason",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25.0),
                ),
                MaterialButton(
                  onPressed: () {
                    onSuccessButton();
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  splashColor: const Color.fromARGB(255, 34, 65, 241),
                  height: 40,
                  minWidth: 100,
                  child: _isLoading
                      ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                      :
                 const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // submitLeave() {
  //   if (leaveReasonController.text.isEmpty) {
  //     Fluttertoast.showToast(
  //         msg: "Please input all fields !!",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Request Successful.",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }
}
