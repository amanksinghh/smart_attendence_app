import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class RequestLeaveCards extends StatefulWidget {
  const RequestLeaveCards({Key? key}) : super(key: key);

  @override
  State<RequestLeaveCards> createState() => _RequestLeaveCardsState();
}

class _RequestLeaveCardsState extends State<RequestLeaveCards> {
  late DateTime targetMonth, initialDate;
  late String month, year;
  String? formattedDated;
  int noOfDaysCurrentMonth = 0;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController leaveReasonController = TextEditingController();
  TextEditingController leaveTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    targetMonth = DateTime.now();
    initialDate = DateTime.now();
    formattedDated = DateFormat.yMd().format(initialDate);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          // ignore: unnecessary_new
          child: new
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: fromDateController,
                  decoration: InputDecoration(
                      labelText: "From Date",
                      hintText: "Input Date",
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      suffixIcon:
                      IconButton(onPressed: () {}, icon:
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                  const Duration(days: 1)),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));
                          if (pickedDate != null) {
                            setState(() {
                              if (pickedDate.month == DateTime
                                  .now()
                                  .month) {
                                targetMonth =
                                    DateTime(pickedDate.year,
                                        pickedDate.month, DateTime
                                            .now()
                                            .day);
                              } else {
                                targetMonth =
                                    DateTime(pickedDate.year,
                                        pickedDate.month, 1);
                              }
                              initialDate = DateTime(
                                  pickedDate.year, pickedDate.month,
                                  pickedDate.day);
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
                    decoration: InputDecoration(
                      labelText: "To Date",
                      suffixIcon:
                      IconButton(onPressed: () {}, icon:
                       GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: DateTime.now().subtract(
                                  const Duration(days: 1)),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));
                          if (pickedDate != null) {
                            setState(() {
                              if (pickedDate.month == DateTime
                                  .now()
                                  .month) {
                                targetMonth =
                                    DateTime(pickedDate.year,
                                        pickedDate.month, DateTime
                                            .now()
                                            .day);
                              } else {
                                targetMonth =
                                    DateTime(pickedDate.year,
                                        pickedDate.month, 1);
                              }
                              initialDate = DateTime(
                                  pickedDate.year, pickedDate.month,
                                  pickedDate.day);
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
                  child: TextFormField(
                    controller: leaveReasonController,
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
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    controller: leaveTypeController,
                    decoration: const InputDecoration(
                      labelText: "Leave Type",
                      prefixIcon: Icon(Icons.note),
                      fillColor: Colors.white,
                      hintText: "Enter Type",
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
                    submitLeave();
                  },
                  child: const Text("Submit"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  splashColor:
                  const Color.fromARGB(255, 34, 65, 241),
                  height: 40,
                  minWidth: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitLeave() {
    if (leaveReasonController.text.isEmpty ||
        leaveTypeController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please input all fields !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Request Successful.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
