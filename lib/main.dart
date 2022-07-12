import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cross_file_image/cross_file_image.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar:
                AppBar(title: const Text('Pick Image From Camera & Gallery')),
            body: Center(child: MyImagePicker())));
  }
}

class MyImagePicker extends StatefulWidget {
  @override
  MyImagePickerState createState() => MyImagePickerState();
}

class MyImagePickerState extends State {
  late XFile imageURI;
  final ImagePicker _picker = ImagePicker();
  Future getImageFromCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      imageURI = image!;
    });
  }

  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageURI = image!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          imageURI == null
              ? Text('No image selected.')
              : Image(
                  image: XFileImage(imageURI),
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover),
          Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: ElevatedButton(
                onPressed: () => getImageFromCamera(),
                child: Text('Click Here To Select Image From Camera'),
              )),
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ElevatedButton(
                onPressed: () => getImageFromGallery(),
                child: Text('Click Here To Select Image From Gallery'),
              ))
        ])));
  }
}
