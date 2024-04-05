import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'update_record.dart';
import 'dart:convert';

class view_data extends StatefulWidget {
  view_data({Key? key}) : super(key: key);

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {
  List userdata = [];

  Future<void> delrecord(String id) async {
    try {
      String uri = "http://192.168.47.1/eventsdb/delete_data.php";
      var res = await http.post(Uri.parse(uri), body: {"id": id});
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("record deleted");
        getrecord();
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getrecord() async {
    String uri = "http://192.168.47.1/eventsdb/view_data.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        userdata = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    //TODO: implement initState
    getrecord();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Events")),
      body: ListView.builder(
        itemCount: userdata.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateRecord(
                      userdata[index]["id"],
                      userdata[index]["name"],
                      userdata[index]["descr"],
                      userdata[index]["date"],
                      userdata[index]["stime"],
                      userdata[index]["etime"],
                    ),
                  ),
                );
              },
              title: Text(userdata[index]["name"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description: ${userdata[index]["descr"]}"),
                  Text("Date: ${userdata[index]["date"]}"),
                  Text("Start Time: ${userdata[index]["stime"]}"),
                  Text("End Time: ${userdata[index]["etime"]}"),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  delrecord(userdata[index]["id"]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}