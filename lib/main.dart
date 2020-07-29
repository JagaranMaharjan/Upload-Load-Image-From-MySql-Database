import 'package:file_upload/imageUploadUi.dart';
import 'package:file_upload/viewAllImage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ImageUpload());
}

class ImageUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Image Upload In SQL",
      home: ImageUploadUi(),
      routes: {
        ViewAllImage.routeName : (context) => ViewAllImage(),
      },
    );
  }
}


