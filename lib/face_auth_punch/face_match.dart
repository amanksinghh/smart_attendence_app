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
  const FaceMatch({super.key});

  @override
  _FaceMatchState createState() => _FaceMatchState();
}

class _FaceMatchState extends State<FaceMatch> {
  var image1 =  regula.MatchFacesImage();
  var image2 =  regula.MatchFacesImage();
  var img1;
  var img2;
  List<String>? userFaceData;
  String _similarity = "nil";
  String _captureImage = "nil";

  String? authToken;
  Users? userById;

  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("authToken");
    getUsers();
    return authToken;
  }

  Future<void> getUsers() async {
    var url = 'https://attandance-server.onrender.com/user';
    Response response = await http.get(Uri.parse(url),headers: {
      'Authorization': 'Bearer $authToken',
    });
    if (response.statusCode == 200) {
        var userListResponse =
        UserByIdResponse.fromJson(json.decode(response.body));
        var userDetails = userListResponse.users;
        userById = userDetails;
        userFaceData = userById?.userFaceData;
        print(userFaceData![0]);
        setState(() {
          img2 = Image.network(userFaceData![0]);
          img1 = Image.network(userFaceData![0]);
        });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong !"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          dismissDirection: DismissDirection.down,
          elevation: 10,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getLoginData();
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
    setState(() => _similarity = "nil");
    if (first) {
      image1.bitmap = base64Encode(imageFile);
      image1.imageType = type;
      setState(() {
        img1 = Image.memory(imageFile);
        _captureImage = "nil";
      });
    } else {
      image2.bitmap = base64Encode(imageFile);
      image2.imageType = type;
      setState(() => img2 = Image.memory(imageFile));
    }
  }

  clearResults() {
    setState(() {
      img1 = Image.asset('assets/images/image.jpg');
      img2 = Image.asset('assets/images/image.jpg');
      _similarity = "nil";
      _captureImage = "nil";
    });
    image1 =  regula.MatchFacesImage();
    image2 =  regula.MatchFacesImage();
  }

  matchFaces() {
    if (image1.bitmap == null ||
        image1.bitmap == "") return;
    setState(() => _similarity = "Processing...");
    var request =  regula.MatchFacesRequest();
    request.images = [image1, image2];
    regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
      var response = regula.MatchFacesResponse.fromJson(json.decode(value));
      regula.FaceSDK.matchFacesSimilarityThresholdSplit(
          jsonEncode(response!.results), 0.75)
          .then((str) {
        var split = regula.MatchFacesSimilarityThresholdSplit.fromJson(
            json.decode(str));
        setState(() => _similarity = split!.matchedFaces.isNotEmpty
            ? ("${(split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)}%")
            : "error");
      });
    });
  }

  captureImageFunc() => regula.FaceSDK.startLiveness().then((value) {
    var result = regula.LivenessResponse.fromJson(json.decode(value));
    setImage(true, base64Decode(result!.bitmap!.replaceAll("\n", "")),
        regula.ImageType.LIVE);
    matchFaces();
    setState(() => _captureImage = result.liveness == 0 ? "passed" : "Failed");
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
              // createButton("Liveliness", () => liveness()),
              captureImageFunc(),
              //createButton("Clear", () => clearResults()),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Similarity: $_similarity",
                          style: const TextStyle(fontSize: 18)),
                      Container(margin: const EdgeInsets.fromLTRB(20, 0, 0, 0)),
                      Text("Liveliness: $_captureImage",
                          style: const TextStyle(fontSize: 18))
                    ],
                  ))
            ])),
  );
}