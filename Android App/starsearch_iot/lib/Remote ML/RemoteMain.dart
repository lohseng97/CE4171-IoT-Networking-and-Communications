import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starsearch_iot/CommonML/PredictionResult.dart';
import '../Main/NavigationManager.dart';
import '../Main/Drawer.dart';
import '../Main/TabScreen.dart';
import '../CommonML/ResultBox.dart';

class RemoteML extends StatefulWidget {
  static const routeName = '/RemoteML';
  @override
  _RemoteML createState() => _RemoteML();
}

class _RemoteML extends State<RemoteML> {
  File image;
  Future<RemotePrediction> prediction;
  BuildContext context;

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    final selectedFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (selectedFile != null) {
        image = File(selectedFile.path);
      } else {
        NavigationManager.noImgError(context);
      }
    });
  }

  Future getImageFromCamera() async {
    final selectedFile =
        await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (selectedFile != null) {
        image = File(selectedFile.path);
      } else {
        NavigationManager.noImgError(context);
      }
    });
  }

  Future<RemotePrediction> remoteML(File selectedImage) async {
    var url = Uri.parse('http://starsearch.lohseng.tech:5000/upload');

    final request = http.MultipartRequest("POST", url);
    final headers = {"Content-type": "multipath/form-data"};

    request.files.add(
      http.MultipartFile('image', selectedImage.readAsBytes().asStream(),
          selectedImage.lengthSync(),
          filename: selectedImage.path.split('/').last),
    );

    request.headers.addAll(headers);
    print("Request: " + request.toString());

    var response = await request.send();
    var res = await http.Response.fromStream(response);

    print('Response status: ${res.statusCode}');
    if (res.statusCode == 201 || res.statusCode == 200) {
      print("POST OK");
      print(jsonDecode(res.body));
      var jsonData = jsonDecode(res.body);
      return RemotePrediction.fromJson(jsonData);
    } else {
      var errorCode = res.statusCode;
      var errorText = res.body;
      ResultBox.noConnectionError(context, errorCode, errorText);
      throw Exception('Failed to Load Prediction!');
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload Image"),
        ),
        drawer: MainDrawer(),
        bottomNavigationBar: TabScreen(2),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (!await Permission.camera.isGranted) {
                            await Permission.camera.request();
                            getImageFromCamera();
                          } else {
                            getImageFromCamera();
                          }
                        },
                        splashColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            'Take a Photo using Camera',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.limeAccent.withOpacity(0.8),
                                Colors.green,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(2.5)),
                      InkWell(
                        onTap: () async {
                          if (!await Permission.photos.isGranted) {
                            await Permission.photos.request();
                            openAppSettings();
                          } else {
                            getImageFromGallery();
                          }
                        },
                        splashColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            'Choose Photo from Gallery',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.tealAccent.withOpacity(0.8),
                                Colors.teal,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(20.0)),
                      InkWell(
                        onTap: () async {
                          if (image != null) {
                            remoteML(image);
                          } else {
                            NavigationManager.noImgError(context);
                          }
                        },
                        splashColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            'Upload to Server',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.orangeAccent.withOpacity(0.8),
                                Colors.deepOrange,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(30.0)),
                      FutureBuilder(
                        future: remoteML(image),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              padding: const EdgeInsets.all(25),
                              child: Text(
                                "Upload Image for prediction of image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'RobotoCondensed',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pink.withOpacity(0.8),
                                    Colors.pinkAccent,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            String filename = snapshot.data.filename;
                            String predictor = snapshot.data.classname;
                            String accuracy = snapshot.data.accuracy;
                            String time = snapshot.data.timeStamp;
                            return Container(
                                padding: const EdgeInsets.all(25),
                                child: Text(
                                  'Predicted Class: $predictor \nAccuracy: $accuracy \nTime uploaded: $time \nFilename: $filename',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'RobotoCondensed',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepPurple.withOpacity(0.8),
                                      Colors.deepPurpleAccent,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ));
                          } else {
                            return Container(
                                padding: const EdgeInsets.all(25),
                                child: Text(
                                  '${snapshot.error}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'RobotoCondensed',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepPurple.withOpacity(0.8),
                                      Colors.deepPurpleAccent,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ));
                          }
                        },
                      )
                    ]))));
  }
}

class RemotePrediction {
  final String classname;
  final String accuracy;
  final String timeStamp;
  final String filename;

  RemotePrediction(
      {this.filename, this.classname, this.accuracy, this.timeStamp});

  factory RemotePrediction.fromJson(Map<String, dynamic> json) {
    return RemotePrediction(
      filename: json['filename'],
      classname: json['classname'],
      accuracy: json['accuracy'],
      timeStamp: json['uploadtime'],
    );
  }
}
