// ignore_for_file: prefer_const_constructors

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendence_app/pages/homepage/homepage.dart';

import '../theme/colors.dart';
import 'summary_page.dart';
import 'my_feeds.dart';
import 'profile_page.dart';
import 'cafeteria_page.dart';

class RootApp extends StatefulWidget {
  final int pageIndex;

  RootApp({required this.pageIndex});

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  late int pageIndex;

  List<Widget> pages = [
    // DailyPage(),
    HomePage(),
    CafeteriaPage(),
    SummaryPage(),
    ProfilePage(),
    MyFeedsPage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    pageIndex = widget.pageIndex;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              selectedTab(4);
            },
            backgroundColor: Color.fromARGB(255, 252, 250, 251),
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              width: 50,
              height: 40,
            )
            //params
            ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked);
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Icons.dashboard_sharp,
      Icons.local_cafe,
      Icons.wallet_travel_sharp,
      Icons.person_sharp,
    ];
    return AnimatedBottomNavigationBar(
      activeColor: Colors.blue,
      splashColor: Colors.blue,
      inactiveColor: Colors.black87,
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.smoothEdge,
      leftCornerRadius: 10,
      iconSize: 27,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
