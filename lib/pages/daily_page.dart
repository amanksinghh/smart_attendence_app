
import 'package:flutter/material.dart';

import '../json/daily_json.dart';
import '../json/day_month.dart';
import '../theme/colors.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  int? activeDay;
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
                  top: 50, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Attendance Summary",
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(days.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                activeDay = index;
                              });
                            },
                            child: Container(
                              width: (MediaQuery.of(context).size.width - 40) / 7,
                              child: Column(
                                children: [
                                  Text(
                                    days[index]['label'],
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: activeDay == index
                                              ? primary
                                              : Colors.transparent,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: activeDay == index
                                                  ? primary
                                                  : black.withOpacity(0.1))),
                                      child: Center(
                                        child: Text(
                                          days[index]['day'],
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: activeDay == index
                                                  ? white
                                                  : black),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
          child: Row(
            children: [
              Text("Working Day",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
              Spacer(),
              Spacer(),
              Text("Check In",style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
              Spacer(),
              Text("Check out",style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
            ],
          ),),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                children: List.generate(daily.length, (index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex:2,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 1),
                          child: Row(
                            children: [
                              // Container(
                              //   width: 50,
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //     shape: BoxShape.circle,
                              //     color: grey.withOpacity(0.1),
                              //   ),
                                // child: Center(
                                //   child: Image.asset(
                                //     daily[index]['icon'],
                                //     width: 30,
                                //     height: 30,
                                //   ),
                                // ),
                              // ),
                              Flexible(
                                flex:1,
                                child: Container(
                                  width: (size.width - 90) * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        daily[index]['name'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: black,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        daily[index]['date'],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: black.withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(),


                      Container(
                       // width: (size.width - 40) * 0.3,
                        child: Align(
                          child: Text(
                            daily[index]['checkedInTime'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.green),
                          ),
                        ),
                      ),
                      Spacer(),

                      Container(
                        //width: (size.width - 40) * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              daily[index]['checkedOutTime'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only( top: 8),
                    child: Divider(
                      thickness: 0.8,
                    ),
                  )
                ],
              );
            })),
          ),
          SizedBox(
            height: 15,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20),
          //   child: Row(
          //     children: [
          //       Spacer(),
          //       // Padding(
          //       //   padding: const EdgeInsets.only(right: 80),
          //       //   child: Text(
          //       //     "Total",
          //       //     style: TextStyle(
          //       //         fontSize: 16,
          //       //         color: black.withOpacity(0.4),
          //       //         fontWeight: FontWeight.w600),
          //       //     overflow: TextOverflow.ellipsis,
          //       //   ),
          //       // ),
          //       // Spacer(),
          //       // Padding(
          //       //   padding: const EdgeInsets.only(top: 5),
          //       //   child: Text(
          //       //     "\$1780.00",
          //       //     style: TextStyle(
          //       //         fontSize: 20,
          //       //         color: black,
          //       //         fontWeight: FontWeight.bold),
          //       //     overflow: TextOverflow.ellipsis,
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
