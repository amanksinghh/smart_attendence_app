import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_face_api/face_api.dart' as regula;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_models/responses/user_by_id_response.dart';

class FaceMatch extends StatefulWidget {
  const FaceMatch({
    super.key,
    required this.imageString,
  });

  final String imageString;

  @override
  _FaceMatchState createState() => _FaceMatchState();
}

class _FaceMatchState extends State<FaceMatch> {
  var image1 = regula.MatchFacesImage();
  var image2 = regula.MatchFacesImage();
  var img1;
  var img2;
  List<String>? userFaceData;
  String _similarity = "nil";
  String _captureImage = "nil";

  String? authToken;
  Users? userById;


  @override
  void initState() {
    super.initState();
    img1 = Image.network(widget.imageString);
    img2 = Image.network(widget.imageString);
    initPlatformState();
    captureImageFunc();
  }

  Future<void> initPlatformState() async {}

  showAlertDialog(BuildContext context, bool first) => showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(title: const Text("Select option"), actions: [
            // ignore: deprecated_member_use
            TextButton(
                child: const Text("Use gallery"),
                onPressed: () {
                  ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((value) => {
                    setImage(
                        first,
                        io.File(value!.path).readAsBytesSync(),
                        regula.ImageType.PRINTED)
                  });
                }),
            // ignore: deprecated_member_use
            TextButton(
                child: const Text("Use camera"),
                onPressed: () {
                  regula.FaceSDK.presentFaceCaptureActivity().then((result) =>
                      setImage(
                          first,
                          base64Decode(regula.FaceCaptureResponse.fromJson(
                              json.decode(result))!
                              .image!
                              .bitmap!
                              .replaceAll("\n", "")),
                          regula.ImageType.LIVE));
                  Navigator.pop(context);
                })
          ]));

  setImage(bool first, Uint8List? imageFile, int type) {
    if (imageFile == null) return;
    setState(() => _similarity = "Not matched");
    if (first) {
      image1.bitmap = base64Encode(imageFile);
      image1.imageType = type;
      setState(() {
        img1 = Image.memory(imageFile);
        _captureImage = "Not matched";
      });
    }
      image2.bitmap = base64Encode(imageFile);
      image2.imageType = type;
      setState(() => img2 = Image.network(widget.imageString));
  }

  clearResults() {
    setState(() {
      img1 = Image.asset('assets/images/test_image.jpeg');
      img2 = Image.asset('assets/images/test_image.jpeg');
      _similarity = "nil";
      _captureImage = "nil";
    });
    image1 = regula.MatchFacesImage();
    image2 = regula.MatchFacesImage();
  }

  matchFaces() {
    if (image1.bitmap == null || image1.bitmap == "") return;
    setState(() => _similarity = "Processing...");
    var request = regula.MatchFacesRequest();
    request.images = [image1, image2];
    regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
      var response = regula.MatchFacesResponse.fromJson(json.decode(value));
      regula.FaceSDK.matchFacesSimilarityThresholdSplit(
          jsonEncode(response!.results), 0.75)
          .then((str) {
        var split = regula.MatchFacesSimilarityThresholdSplit.fromJson(
            json.decode(str));
        setState(() => _similarity = split!.matchedFaces.isNotEmpty
            ? punchInData()
            : errorFaceData());
      });
    });
  }

  punchInData() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString("authToken", userLoginResponse.token!);
    // ApiCalls().putLatLong(
    //     context, position, formattedDate, authToken);

    ///for match percentage.
    //("${(split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)}%")

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Face Matched and Puched_In"),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  errorFaceData() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString("authToken", userLoginResponse.token!);
    // ApiCalls().putLatLong(
    //     context, position, formattedDate, authToken);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Face doesn't match try again !!"),
        backgroundColor: Colors.red,
      ),
    );
    Navigator.pop(context);
  }

  captureImageFunc() => regula.FaceSDK.startLiveness().then((value) {
    var result = regula.LivenessResponse.fromJson(json.decode(value));
    setImage(true, base64Decode(result!.bitmap!.replaceAll("\n", "")),
        regula.ImageType.LIVE);
    matchFaces();
    setState(
            () => _captureImage = result.liveness == 0 ? "passed" : "Failed");
  });

  Widget createButton(String text, VoidCallback onPress) => Container(
    // ignore: deprecated_member_use
    width: 250,
    // ignore: deprecated_member_use
    child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
        ),
        onPressed: onPress,
        child: Text(text)),
  );

  Widget createImage(image, VoidCallback onPress) => Material(
      child: InkWell(
        onTap: onPress,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image(height: 150, width: 150, image: image),
        ),
      ));

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              createImage(img1.image, () => showAlertDialog(context, true)),
              createImage(
                  img2.image, () => showAlertDialog(context, false)),
              Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 15)),
              //createButton("Liveliness", () => captureImageFunc()),
              //captureImageFunc(),
              //createButton("Clear", () => clearResults()),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Similarity: $_similarity",
                          style: const TextStyle(fontSize: 18)),
                      Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 0)),
                      Text("Live Captured: $_captureImage",
                          style: const TextStyle(fontSize: 18))
                    ],
                  ))
            ])),
  );
}