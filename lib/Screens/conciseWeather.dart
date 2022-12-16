import 'package:KnowWeather/providers/citylist.dart';
import 'package:KnowWeather/widgets/bottombar.dart';
import 'package:KnowWeather/widgets/drawer_scree.dart';
import 'package:KnowWeather/widgets/sunrisesunset.dart';
import 'package:KnowWeather/widgets/tempdisplay.dart';
import 'package:KnowWeather/widgets/wind_pressure.dart';
import 'package:flutter/material.dart';
import '../widgets/air_quality.dart';
import 'package:provider/provider.dart';

class WeatherDeatals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<CityList>(context).citydata;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('KnowWeather'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('/addcity');
              })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(data.imageurl), fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height * 0.88,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: CurrentTemp(data, 0)),
              Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: Windpressure(data, 0)),
              Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: AirQuality(data)),
              Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: SunMoonRise(data, 0)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottombar(0),
    );
  }
}
