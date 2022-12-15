import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Products extends StatefulWidget {
  Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.description,
                          color: Color.fromARGB(255, 123, 28, 247),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Details',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10, left: 160),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'Edit Assembly',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                          color: Color.fromARGB(255, 126, 78, 214),
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          splashColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new SizedBox(
                height: 0,
              ),
              Divider(
                color: Color.fromARGB(129, 63, 63, 63),
                height: 2,
                thickness: 0.7,
              ),
              new SizedBox(
                height: 5,
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 0),
                            child: Column(
                              children: [
                                
                                Container(
                                    child: new Form(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Customer',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 126, 78, 214),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                                hintText: "PRC-001",
                                                fillColor: Colors.white),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'AIM#',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 126, 78, 214),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                hintText: "A0-867",
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'DESC#',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 126, 78, 214),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                hintText: "A0-867",
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'REV',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 126, 78, 214),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                hintText: "B1",
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: MaterialButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Active',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              color: Color.fromARGB(
                                                  255, 126, 78, 214),
                                              textColor: Colors.white,
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              splashColor: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    width: 160,
                                    height: 360),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 3),
                          child: Container(
                            color: Color.fromARGB(125, 37, 77, 255),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/prc-77a-module-a77a.jpg'),
                              fit: BoxFit.fill,
                              width: 180,
                              height: 240,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              new SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 0),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(176, 187, 235, 187),
                      border:
                          Border.all(color: Color.fromARGB(178, 177, 218, 177)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                          'First Article Status :',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 39, 43, 37),
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        child: Text(
                          'Approved',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 1, 124, 1),
                              fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 31, 199, 31),
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        )),
      ),
    );
  }
}
