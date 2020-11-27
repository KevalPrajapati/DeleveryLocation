import 'package:flutter/material.dart';
import 'package:mapapi/Selectlocation.dart';

class GetPhone extends StatefulWidget {
  @override
  GetPhoneState createState() => GetPhoneState();
}

class GetPhoneState extends State<GetPhone> {
  String phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (val) {
              phone = val;
            },
            decoration: InputDecoration(hintText: "Enter phone number"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MapSample(phone: phone),
              ),
            );
          },
          child: Icon(Icons.arrow_right_alt)),
    );
  }
}
