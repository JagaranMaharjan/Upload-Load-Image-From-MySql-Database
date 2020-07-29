import 'package:file_upload/viewAllImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ImageUploadUi extends StatefulWidget {

  @override
  _ImageUploadUiState createState() => _ImageUploadUiState();
}

class _ImageUploadUiState extends State<ImageUploadUi> {
  //this variable is used to save image from camera or gallery
  File _image;
  //method to get image from gallery
  Future getImageFromGallery() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }
  //method to get image from camera
  Future getImageFromCamera() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedImage.path);
    });
  }
  //method to upload image in local database
  Future upload(File imageFile) async {
    //url of local database
    final uri = Uri.parse("http://192.168.1.102/UploadImage/uploadImage.php");
    //http request to post data
    var request = new http.MultipartRequest("POST", uri);
    //request.fields['name']=title
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image uploaded");
    } else {
      print("Upload failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Image Upload In SQL"),
          actions: <Widget>[
            //to view all images from local database
            FlatButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(ViewAllImage.routeName);
              },
              icon: Icon(Icons.remove_red_eye),
              label: Text("View All"),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            /*
            * if image contains any value then it will display image otherwise
            * it will display text as no image selected
            * */
            Center(
              child: _image == null
                  ? new Text("No Image Selected")
                  : Image.file(_image),
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.image),
                  onPressed: getImageFromGallery,
                ),
                RaisedButton(
                  child: Icon(Icons.camera_alt),
                  onPressed: getImageFromCamera,
                ),
                Expanded(
                  child: Container(),
                ),
                RaisedButton(
                  child: Text("UPLOAD"),
                  onPressed: () {
                    upload(_image);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
