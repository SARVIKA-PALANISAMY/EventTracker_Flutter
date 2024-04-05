import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class UpdateRecord extends StatefulWidget {
  String id;
  String name;
  String descr;
  String date;
  String stime;
  String etime;

  UpdateRecord(this.id, this.name, this.descr, this.date, this.stime, this.etime);

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descrController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController stimeController = TextEditingController();
  TextEditingController etimeController = TextEditingController();

  Future<void> fetchData() async {
    try {
      String uri = "http://192.168.47.1/eventsdb/fetch_data.php"; // Update with your fetch data endpoint

      var res = await http.get(Uri.parse(uri));
      var response = jsonDecode(res.body);

      if (response != null && response.isNotEmpty) {
        setState(() {
          widget.id = response[0]["id"];
          widget.name = response[0]["name"];
          widget.descr = response[0]["descr"];
          widget.date = response[0]["date"];
          widget.stime = response[0]["stime"];
          widget.etime = response[0]["etime"];

          nameController.text = widget.name;
          descrController.text = widget.descr;
          dateController.text = widget.date;
          stimeController.text = widget.stime;
          etimeController.text = widget.etime;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateRecord() async {
    try {
      String uri = "http://192.168.47.1/eventsdb/update_data.php";

      var res = await http.post(Uri.parse(uri), body: {
        "id": widget.id,
        "name": nameController.text,
        "descr": descrController.text,
        "date": dateController.text,
        "stime": stimeController.text,
        "etime": etimeController.text,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == true) {
        print("updated");
        fetchData();
        
        // Show an AlertDialog if update is successful
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Update successful!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    nameController.text = widget.name;
    descrController.text = widget.descr;
    dateController.text = widget.date;
    stimeController.text = widget.stime;
    etimeController.text = widget.etime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Event')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Event',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: descrController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Event Description',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Event Date (YYYY-MM-DD)',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: stimeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Event Start Time',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: etimeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Event End Time',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  updateRecord();
                },
                child: Text('Update Event'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UpdateRecord('1', 'Initial Name', 'Initial Description', '2023-12-28', '12:00', '14:00'),
  ));
}