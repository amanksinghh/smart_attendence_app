import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:smart_attendence_app/pages/attendance_summary/daily_page.dart';

import '../theme/colors.dart';
import 'attendance_summary/monthly.dart';
import 'attendance_summary/weekly.dart';

class AttendanceSummary extends StatefulWidget {
  const AttendanceSummary({Key? key}) : super(key: key);

  @override
  State<AttendanceSummary> createState() => _AttendanceSummaryState();
}

class _AttendanceSummaryState extends State<AttendanceSummary> {
  double screenHeight = 0;
  double screenWidth = 0;
  int _selectedWidget = 0;

  Color primary = const Color(0xffeef444c);

  String _month = DateFormat('MMMM').format(DateTime.now());

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(_selectedWidget == 0){
      MonthlyPage();
    }
    if(_selectedWidget == 1){
      WeeklyPage();
    }
    if(_selectedWidget == 2){
      DailyPage();
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    //margin: const EdgeInsets.only(top: 10),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Attendance Summary",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top:30,bottom:10),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,horizontal: 0,
                              ),
                                child: TextButton(
                                  child: Text(
                                    'Monthly',
                                  overflow: TextOverflow.visible,
                                    style: _selectedWidget==0
                                    ? const TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                    )
                                    : const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      _selectedWidget = 0;
                                    });
                                  },
                                ),

                            ),
                          ),
                          SizedBox(width: 1,),
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,horizontal: 0,
                              ),
                              child: TextButton(
                                child: Text(
                                  'Weekly',
                                  overflow: TextOverflow.visible,
                                  style: _selectedWidget==1
                                      ? const TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue,
                                  )
                                      : const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                onPressed: (){
                                  setState(() {
                                    _selectedWidget = 1;
                                  });
                                },
                              ),

                            ),
                          ),
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,horizontal: 0,
                              ),
                              child: TextButton(
                                child: Text(
                                  'Daily',
                                  overflow: TextOverflow.visible,
                                  style: _selectedWidget==2
                                      ? const TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue,
                                  )
                                      : const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                onPressed: (){
                                  setState(() {
                                    _selectedWidget = 2;
                                  });
                                },
                              ),

                            ),
                          ),


                        ],
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 10,
              ),
              _selectedWidget == 0
                  ? const MonthlyPage()
                  : _selectedWidget == 1
                    ? const WeeklyPage()
                    : DailyPage(),



            ],
          ),
        ),
      ),
    );
  }
}
