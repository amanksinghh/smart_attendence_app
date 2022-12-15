import 'package:flutter/material.dart';

class StackBuilder extends StatefulWidget {
  StackBuilder({Key? key}) : super(key: key);

  @override
  State<StackBuilder> createState() => _StackBuilderState();
}

class _StackBuilderState extends State<StackBuilder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Flutter Stack Widget',
                  style: TextStyle(
                      fontSize: 26,
                      shadows: [
                        Shadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(2, 2))
                      ],
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Let\'s learn how to implement it',
                  style: TextStyle(
                      fontSize: 16,
                      shadows: [
                        Shadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(2, 2))
                      ],
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(2, 2))
                    ]),
                child: ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Center(
                          child: Container(
                        margin: EdgeInsets.all(10),
                        height: 245,
                        width: 320,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 7,
                                  spreadRadius: 2,
                                  offset: Offset(3, 3))
                            ]),
                        child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: 180,
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(15).copyWith(top: 0),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 7,
                                          spreadRadius: 2,
                                          offset: Offset(2, 2)),
                                    ]),
                                child: Container(
                                  height: 150,
                                  width: 270,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: Container(
                                          height: 100,
                                          width: 240,
                                          decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 3,
                                                    spreadRadius: 1,
                                                    offset: Offset(2, 2)),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 15,
                                        right: 15,
                                        child: Container(
                                          height: 100,
                                          width: 240,
                                          decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 3,
                                                    spreadRadius: 1,
                                                    offset: Offset(2, 2)),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 25,
                                        right: 25,
                                        child: Container(
                                          padding: EdgeInsets.all(10)
                                              .copyWith(bottom: 0),
                                          height: 100,
                                          width: 240,
                                          decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 3,
                                                    spreadRadius: 1,
                                                    offset: Offset(2, 2)),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Name: ',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Zeeshan',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black45,
                                                          shadows: [
                                                            Shadow(
                                                                blurRadius: 2,
                                                                color: Colors
                                                                    .black12,
                                                                offset: Offset(
                                                                    1, 1))
                                                          ],
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Email: ',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'zeerockyf5@gmail.com',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black45,
                                                          shadows: [
                                                            Shadow(
                                                                blurRadius: 2,
                                                                color: Colors
                                                                    .black12,
                                                                offset: Offset(
                                                                    1, 1))
                                                          ],
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Interest: ',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Mobile Apps',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black45,
                                                          shadows: [
                                                            Shadow(
                                                                blurRadius: 2,
                                                                color: Colors
                                                                    .black12,
                                                                offset: Offset(
                                                                    1, 1))
                                                          ],
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Website: ',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    'letmeflutter.com',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black45,
                                                        shadows: [
                                                          Shadow(
                                                              blurRadius: 2,
                                                              color: Colors
                                                                  .black12,
                                                              offset:
                                                                  Offset(1, 1))
                                                        ],
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w900),
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
                            ),
                            Positioned(
                              right: 0,
                              left: 0,
                              child: Container(
                                height: 70,
                                width: 70,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/development.jpg')),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 7,
                                          spreadRadius: 2,
                                          offset: Offset(2, 2))
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ));
                    }),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Happy Coding',
                  style: TextStyle(
                      fontSize: 16,
                      shadows: [
                        Shadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(2, 2))
                      ],
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
