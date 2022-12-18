// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_attendence_app/pages/homepage/homepage.dart';

import 'budget_page.dart';
import 'create_budge_page.dart';
import 'daily_page.dart';
import 'profile_page.dart';
import 'stats_page.dart';
import '../theme/colors.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  List<Widget> pages = [
   // DailyPage(),
    HomePage(),
    StatsPage(),
    BudgetPage(),
    ProfilePage(),
    CreatBudgetPage()
  ];

  @override
  void initState() {
    // TODO: implement initState
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
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              width: 50,
              height: 40,
            ),
            backgroundColor: Color.fromARGB(255, 252, 250, 251)
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
      Icons.stacked_bar_chart_sharp,
      Icons.wallet_travel_sharp,
      Icons.person_sharp,
    ];
    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Color.fromARGB(255, 70, 31, 0).withOpacity(0.9),
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
