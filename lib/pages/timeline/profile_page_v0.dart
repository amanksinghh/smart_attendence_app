import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendence_app/model/user.dart';
import 'package:smart_attendence_app/pages/daily_page.dart';
import 'package:smart_attendence_app/pages/edit_profile_page.dart';
import 'package:smart_attendence_app/pages/stats_page.dart';
import 'package:smart_attendence_app/utils/user_preferences.dart';
import 'package:smart_attendence_app/widgets/numbers_widgets.dart';
import 'package:smart_attendence_app/widgets/profile_edit_widget.dart';

import '../login_utils/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Container(
              height: 60, child: Image.asset('assets/images/logo.png')),
        ),
        endDrawerEnableOpenDragGesture: true,
        endDrawer: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3,

          margin: EdgeInsets.only(right: 10, bottom: 300),
//height: 480,
          child: Drawer(
            child: ListView(
// Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: Row(children: [
                    Text('Dashboard'),
                    Spacer(),
                    Icon(Icons.dashboard)
                  ]),
                  onTap: () {
// Update the state of the app
// ...
// Then close the drawer
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DailyPage()));
                  },
                ),
                ListTile(
                  title: Row(children: [
                    Text('Stat'),
                    Spacer(),
                    Icon(
                      Icons.stacked_bar_chart_sharp,
                    )
                  ]),
                  onTap: () {
// Update the state of the app
// ...
// Then close the drawer
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StatsPage()));
                  },
                ),
                ListTile(
                  title: Row(children: [
                    Text('Logout'),
                    Spacer(),
                    Icon(
                      Icons.logout_sharp,
                    )
                  ]),
                  onTap: () {
// Update the state of the app
// ...
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 24),
            NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(user),
          ],
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
