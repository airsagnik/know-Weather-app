import 'package:flutter/material.dart';

class Waiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("KnowWeather"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 5,
              ),
              Text("Fetching data...")
            ],
          ),
        ));
  }
}
