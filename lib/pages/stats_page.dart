import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import '../json/day_month.dart';
import '../theme/colors.dart';
import '../widgets/chart.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int activeDay = 3;

  bool showAvg = false;

  TextEditingController searchController = TextEditingController();
  bool searchbarVisible = false;


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    searchController.text.split(" ").first.trim();
    searchController.text.split(" ").last.trim();
  }

  @override
  void dispose() {
    super.dispose();
    // searchbarFocus.dispose();
    searchController.dispose();
    // print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    List expenses = [
      {
        "icon": Icons.arrow_back,
        "color": blue,
        "label": "Income",
        "cost": "\$6593.75"
      },
      {
        "icon": Icons.arrow_forward,
        "color": red,
        "label": "Expense",
        "cost": "\$2645.50"
      }
    ];
    return SingleChildScrollView(
      child: Column(
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
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stats",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Expanded(
                        child: Visibility(
                            visible: searchbarVisible,
                            child: Stack(children: [
                              Container(
                                height: 29,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 10,left: 10),
                                child: Material(
                                  borderRadius: BorderRadius.circular(5),
                                  elevation: 0,
                                  child: TextFormField(
                                    autofocus: true,
                                    // focusNode: searchbarFocus,
                                    controller: searchController,
                                    onChanged: (value) {
                                      setState(() {

                                        searchController.text
                                            .split(" ")
                                            .first
                                            .trim();
                                        searchController.text
                                            .split(" ")
                                            .last
                                            .trim();
                                      });
                                    },
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(8),
                                        isDense: true,
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 4,
                                  child: Container(
                                      height: 12,
                                      width: 12,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: grey),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            searchbarVisible = false;
                                            searchController.text="";
                                            searchController.text.split(" ").first.trim();
                                            searchController.text.split(" ").last.trim();
                                          });
                                        },
                                        alignment: Alignment.center,
                                        icon: const Icon(
                                          Icons.close,
                                          size: 10,
                                        ),
                                        color: white,

                                      )))
                            ])),
                      ),
                      Visibility(
                        visible: !searchbarVisible,
                        child: IconButton(
                            onPressed: () {
                              if (searchbarVisible == false) {
                                setState(() {
                                  searchbarVisible = true;
                                });
                              } else {
                                setState(() {
                                  searchbarVisible = false;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(months.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              activeDay = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 40) / 6,
                            child: Column(
                              children: [
                                Text(
                                  months[index]['label'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: activeDay == index
                                          ? primary
                                          : black.withOpacity(0.02),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: activeDay == index
                                              ? primary
                                              : black.withOpacity(0.1))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, top: 7, bottom: 7),
                                    child: Text(
                                      months[index]['day'],
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: activeDay == index
                                              ? white
                                              : black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Net balance",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\$2446.90",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: (size.width - 20),
                        height: 150,
                        child: LineChart(
                          mainData(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
              spacing: 20,
              children: List.generate(expenses.length, (index) {
                return Container(
                  width: (size.width - 60) / 2,
                  height: 170,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: expenses[index]['color']),
                          child: Center(
                              child: Icon(
                            expenses[index]['icon'],
                            color: white,
                          )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expenses[index]['label'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff67727d)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              expenses[index]['cost'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }
}
