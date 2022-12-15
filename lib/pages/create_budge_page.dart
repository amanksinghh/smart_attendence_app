import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../face_auth_puch/punch_in.dart';
import '../json/create_budget_json.dart';
import '../theme/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

var profile_image =
    "https://media-exp1.licdn.com/dms/image/C5603AQEob5l8e06qQg/profile-displayphoto-shrink_800_800/0/1652278654609?e=1658361600&v=beta&t=IOrm1Y-2XbJ-wkn8Zy3ZGbcAssPC2gI4jfs4DyShYs4";

class CreatBudgetPage extends StatefulWidget {
  @override
  _CreatBudgetPageState createState() => _CreatBudgetPageState();
}

class _CreatBudgetPageState extends State<CreatBudgetPage> {
  int activeCategory = 0;

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
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, right: 20, left: 20, bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Feed",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      // Row(
                      //   children: [Icon(Icons.search)],
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.3),
                spreadRadius: 6,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: (size.width - 40) * 0.4,
                        child: Container(
                          child: Stack(
                            children: [
                              RotatedBox(
                                quarterTurns: -5,
                                child: CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: grey.withOpacity(0.5),
                                    radius: 60.0,
                                    lineWidth: 4.0,
                                    percent: 0.8,
                                    progressColor: black),
                              ),
                              Positioned(
                                top: 18,
                                left: 16,
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage("$profile_image"),
                                          fit: BoxFit.cover)),
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
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "E23T56",
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
                    height: 33,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: grey.withOpacity(0.01),
                        boxShadow: [
                          BoxShadow(
                            color: grey.withOpacity(0.3),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 2, right: 2, top: 25, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward_outlined,
                                    color: black,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "2:55 PM",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: blue),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Checked In",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: black),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.punch_clock_rounded,
                                    color: primary,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "2:55",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: blue),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "WORKING HOUR ",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: black),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_upward_rounded,
                                color: primary,
                                size: 25,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "CHECKED OUT",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            // scrollDirection: Axis.horizontal,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height ,
            child: Row(
                children: List.generate(categories.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeCategory = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 5,
                    ),
                    width: (size.width - 40) / categories.length,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(
                            width: 2,
                            color: activeCategory == index
                                ? primary
                                : Color.fromARGB(144, 97, 94, 94)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: grey.withOpacity(0.3),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const PunchIn()));
                            },
                            child: Container(
                                width: 60,
                                height: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: grey.withOpacity(0.1)),
                                child: Center(
                                  child: Image.asset(
                                    categories[index]['icon'],
                                    width: 70,
                                    height: 90,
                                    fit: BoxFit.contain,
                                  ),
                                )),
                          ),
                          Text(
                            categories[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 20, left: 20, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TIMELINE",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      // Row(
                      //   children: [Icon(Icons.search)],
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
