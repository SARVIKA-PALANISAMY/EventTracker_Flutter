import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'view_data.dart';
import 'login_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.pink[50],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/insertRecord': (context) => InsertRecord(),
        '/viewData': (context) => view_data(),
      },
    );
  }
}

class InsertRecord extends StatefulWidget {
  @override
  _InsertRecordState createState() => _InsertRecordState();
}

class _InsertRecordState extends State<InsertRecord> {
  TextEditingController name = TextEditingController();
  TextEditingController descr = TextEditingController();
  TextEditingController date = TextEditingController();
  TimeOfDay stime = TimeOfDay.now();
  TimeOfDay etime = TimeOfDay.now();

  Future<void> insertRecord() async {
    if (name.text.isNotEmpty &&
        descr.text.isNotEmpty &&
        date.text.isNotEmpty &&
        stime != null &&
        etime != null) {
      try {
        String uri = "http://192.168.47.1/eventsdb/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "descr": descr.text,
          "date": date.text,
          "stime": "${stime.hour}:${stime.minute}",
          "etime": "${etime.hour}:${etime.minute}",
        });
        var response = json.decode(res.body);
        if (response["success"] == "true") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Record Inserted Successfully!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
          name.text = "";
          descr.text = "";
          date.text = "";
          stime = TimeOfDay.now();
          etime = TimeOfDay.now();
        } else {
          print("Some Issue");
        }
      } catch (e) {
        print(e);
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in all fields."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        date.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}"; 
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        stime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        etime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add the events'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter the Event Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: descr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter the Event Description',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select the Event Date',
                  ),
                  child: Text(date.text),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: () => _selectStartTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select the Event Start Time',
                  ),
                  child: Text("${stime.hour}:${stime.minute}"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: () => _selectEndTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select the Event End Time',
                  ),
                  child: Text("${etime.hour}:${etime.minute}"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  insertRecord();
                },
                child: Text('Insert Event'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => view_data()),
                  );
                },
                child: Text("View Events"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}