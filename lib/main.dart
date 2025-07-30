import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SimpleCrud());
  }
}

class SimpleCrud extends StatefulWidget {
  @override
  _SimpleCrudState createState() => _SimpleCrudState();
}

class _SimpleCrudState extends State<SimpleCrud> {
  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  String result = '';

  // Save data
  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyController.text, valueController.text);
    setState(() {
      result = 'Data Saved!';
    });
  }

  // Read data
  readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(keyController.text);
    setState(() {
      result = data ?? 'No data found';
    });
  }

  // Update data (same as save)
  updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyController.text, valueController.text);
    setState(() {
      result = 'Data Updated!';
    });
  }

  // Delete data
  deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyController.text);
    setState(() {
      result = 'Data Deleted!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple CRUD')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: keyController,
              decoration: InputDecoration(labelText: 'Key'),
            ),
            TextField(
              controller: valueController,
              decoration: InputDecoration(labelText: 'Value'),
            ),
            SizedBox(height: 20),

            Row(
              children: [
                ElevatedButton(onPressed: saveData, child: Text('Save')),
                ElevatedButton(onPressed: readData, child: Text('Read')),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: updateData,
                      child: Text('Update'),
                    ),
                    ElevatedButton(
                      onPressed: deleteData,
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Result: $result'),
          ],
        ),
      ),
    );
  }
}
