import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewAllImage extends StatelessWidget {
  static const routeName = "viewAllImage";

  Future fecthAllImage() async {
    //here i had added 192.168.1.102 which is my pcs preferred ipv4 address
    //i had added this ip address because local host does not work in my scenario
    var url = "http://192.168.1.102/UploadImage/viewAll.php";
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View All Image"),
      ),
      body: FutureBuilder(
        future: fecthAllImage(),
        builder: (context, snapShotData) {
          if (snapShotData.hasError) print(snapShotData.error);
          return snapShotData.hasData
              ? snapShotData.data
                      .isEmpty //if snapshotdata.data doesnot contain any value then it displays database is empty message
                  ? Center(
                      child: Container(
                          child: Text(
                        "Database Is Empty",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
                    )
                  : ListView.builder(
                      //otherwise display images
                      itemCount: snapShotData.data.length,
                      itemBuilder: (context, index) {
                        List list = snapShotData.data;
                        return ListTile(
                          title: Container(
                            child: Image.network(
                                "http://192.168.1.102/UploadImage/images/${list[index]['image']}"),
                          ),
                        );
                      },
                    )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
