import 'package:flutter/material.dart';

import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Details extends StatefulWidget {
  Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        alignment: Alignment.center,
        children: [
          ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              debugPrint('Page changed: $value');
            },
            autoPlayInterval: 3000,
            isLoop: true,
            children: [
              Image(
                image: AssetImage('assets/images/prc-77a-module-a77a.jpg'),
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/prc-77a-module-a77a.jpg'),
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/prc-77a-module-a77a.jpg'),
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/prc-77a-module-a77a.jpg'),
                fit: BoxFit.cover,
              ),
            ],
          ),
          ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              debugPrint('Page changed: $value');
            },
            autoPlayInterval: 3000,
            isLoop: true,
            children: [
              Image(
                image: AssetImage('assets/images/prc-77a-module-a77a.jpg'),
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/prc-77a-module-a77a.jpg'),
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/prc-77a-module-a77a.jpg'),
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/prc-77a-module-a77a.jpg'),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ],
      )),
    );
    ;
  }
}
