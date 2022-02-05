import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Main/NavigationManager.dart';
import '../Main/Drawer.dart';
import '../Main/TabScreen.dart';
import 'RemotePrediction.dart';

class RemoteML extends StatefulWidget {
  static const routeName = '/RemoteML';
  @override
  _RemoteML createState() => _RemoteML();
}

class _RemoteML extends State<RemoteML> {
  File image;
  final picker = ImagePicker();
  Future<RemotePrediction> futurePrediction;

  BuildContext context;

  Future getImageFromGallery() async {
    final selectedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (selectedFile != null) {
        image = File(selectedFile.path);
      } else {
        NavigationManager.remoteImageError(context);
      }
    });
  }

  Future getImageFromCamera() async {
    final selectedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (selectedFile != null) {
        image = File(selectedFile.path);
      } else {
        NavigationManager.remoteImageError(context);
      }
    });
  }

  //To modify
  Future<RemotePrediction> uploadImageToServer(File imageFile) async {
    print("Connecting to server......");
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    // var uri = Uri.parse('http://20.198.224.77:80/predict');
    var uri = Uri.parse('http://127.0.0.1/predict');
    //if it is android simulator change to 10.0.2.2
    print("Connection Established.");
    var request = new http.MultipartRequest("POST", uri);
    print(uri.port);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("Post request responded");
      print(jsonDecode(response.body));
      return RemotePrediction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load prediction');
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload Image"),
        ),
        drawer: MainDrawer(),
        bottomNavigationBar: TabScreen(3),
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
                            futurePrediction = uploadImageToServer(image);
                            CircularProgressIndicator();
                          } else {
                            NavigationManager.remoteImageError(context);
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
                      //To modify
                      if (futurePrediction != null)
                        FutureBuilder<RemotePrediction>(
                          future: futurePrediction,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              String prediction = snapshot.data.predictedClass;
                              String score = snapshot.data.score;
                              String title = snapshot.data.title;
                              String time = snapshot.data.timeStamp;
                              return Container(
                                  padding: const EdgeInsets.all(25),
                                  child: Text(
                                    'The model is $score confident that the image $title, sent at $time is $prediction',
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
                            } else if (snapshot.hasError) {
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
                            return CircularProgressIndicator();
                          },
                        )
                      else
                        Container(
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            'Upload image to get prediction of the health of the leave',
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
                        ),
                    ]))));
  }
}
