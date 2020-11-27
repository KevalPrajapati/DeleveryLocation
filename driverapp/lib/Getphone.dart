import 'package:driverapp/ShowLocation.dart';
import 'package:flutter/material.dart';

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
            decoration: InputDecoration(hintText: "Enter Order Id"),
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
