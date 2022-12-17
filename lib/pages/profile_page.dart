import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart_attendence_app/pages/login_utils/api_service.dart';

import '../theme/colors.dart';

var profile_image =
    "https://media-exp1.licdn.com/dms/image/C5603AQEob5l8e06qQg/profile-displayphoto-shrink_800_800/0/1652278654609?e=1658361600&v=beta&t=IOrm1Y-2XbJ-wkn8Zy3ZGbcAssPC2gI4jfs4DyShYs4";

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _email =
      TextEditingController(text: "ritesh.k@aimtron.com");
  TextEditingController dateOfBirth = TextEditingController(text: "05-02-2002");






  // String getInitials() {
  //   List<String> names = [];
  //   String fullName =
  //   StoreProvider.of<ApiService>(context).state.body.trim();
  //   names.add(fullName.split(" ").first);
  //   names.add(fullName.split(" ").last);
  //   return names.first.substring(0, 1).toUpperCase() +
  //       names.last.substring(0, 1).toUpperCase();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 4,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),

                      //
                      //
                      //
                      //
                      //
                      IconButton(onPressed: (){
                        setState(() {

                        });
                      }, icon: Icon(Icons.settings))
                      // Icon(Icons.settings)
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Container(
                        width: (size.width - 40) * 0.4,
                        child: Container(
                          child: Stack(
                            children: [
                              RotatedBox(
                                quarterTurns: -2,
                                child: CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: grey.withOpacity(0.3),
                                    radius: 50.0,
                                    lineWidth: 6.0,
                                    percent: 0.7,
                                    animationDuration: 5,
                                    progressColor: primary),
                              ),
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Text("RK",
                                        style: TextStyle(
                                            color: Colors.grey,fontSize: 24, fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: (size.width - 40) * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ritesh Kumar",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Mobile App Developer",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.01),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 25, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Emp ID : 2456",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: white),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Mobile App Developer",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: white),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: white)),
                            child: TextButton(
                              child: Text("About Me",
                              style: TextStyle(color: white)),
                              onPressed:(){
                                print("about me button pressed");
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "ritesh.k@aimtron.com",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Date of birth",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "05/02/2002",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
Widget drawerTab(
    {required String text,
      required GestureTapCallback onTap,
      required Icon icons,
      required Color color,
      required BuildContext context}) {
  return Center(
    child: ListTile(
      //selectedColor: logoColor,
      //selectedTileColor: logoColor,
      // selected: true,
      // selectedColor: logoColor,
      trailing: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: icons,
      ),
      iconColor: color,
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(vertical: 3),
      title: Row(
        //  mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              text,
              style:
              TextStyle(color: color, fontSize: 16, fontFamily: "primary-font-family"),
            ),
          )
        ],
      ),
      onTap: onTap,
    ),
  );
}

// To take names and routes of nav Tabs dynamically

class SettingsTab {
  String name;
  Icon icons;
  String route;
  Map? arguments;

  SettingsTab(
      {required this.name,
        required this.route,
        this.arguments,
        required this.icons});
}
