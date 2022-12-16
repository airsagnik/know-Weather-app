import 'package:KnowWeather/providers/citylist.dart';
import 'package:KnowWeather/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";
import 'package:weather_icons/weather_icons.dart';
import 'package:provider/provider.dart';
import '../models/city.dart';

class Mapdisplay extends StatefulWidget {
  @override
  _MapdisplayState createState() => _MapdisplayState();
}

class _MapdisplayState extends State<Mapdisplay> {
  //var date = (((DateTime.now().toUtc().millisecondsSinceEpoch) / 1000) / 60);
  //var apikey = "f3662037848cf91e4960b3271e206d7f";
  String currentlayer = "temp_new";
  String layername = "Temperature";
  double lat = 0.0;
  double lon = 0.0;

  List<String> layers = [
    "temp_new",
    "precipitation_new",
    "clouds_new",
    "pressure_new",
    "wind_new"
  ];
  void chlayer(int i) {
    setState(() {
      currentlayer = layers[i];
      layername = maps[i];
    });
  }

  List<String> maps = [
    "Temperature",
    "Precipitation",
    "Clouds",
    "Sea level pressure",
    "Wind speed"
  ];
  List<Icon> iconlist = [
    Icon(
      WeatherIcons.thermometer,
      color: Colors.white,
      size: 30,
    ),
    Icon(WeatherIcons.rain_mix, color: Colors.white, size: 30),
    Icon(WeatherIcons.cloud, color: Colors.white, size: 30),
    Icon(WeatherIcons.barometer, color: Colors.white, size: 30),
    Icon(WeatherIcons.wind, color: Colors.white, size: 30)
  ];

  void changemaplayer() {
    showModalBottomSheet(
        backgroundColor: Colors.black54,
        context: context,
        builder: (ctx) => ListView.builder(
            itemCount: 5,
            itemBuilder: (ctx, i) => ListTile(
                  onTap: () {
                    chlayer(i);
                    Navigator.of(context).pop();
                  },
                  leading: Text(
                    maps[i],
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  trailing: iconlist[i],
                )));
  }

  @override
  Widget build(BuildContext context) {
    City obj = Provider.of<CityList>(context).citydata;
    lat = obj.latitude;
    lon = obj.longitute;
    return Scaffold(
      appBar: AppBar(
        title: Text(layername),
        actions: [
          IconButton(icon: Icon(Icons.layers), onPressed: changemaplayer)
        ],
      ),
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.80,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(lat, lon),
              minZoom: 3,
              maxZoom: 50,
            ),
            layers: [
              TileLayerOptions(
                opacity: 1,
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              TileLayerOptions(
                opacity: 0.70,
                urlTemplate:
                    'https://tile.openweathermap.org/map/$currentlayer/{z}/{x}/{y}.png?appid=f3662037848cf91e4960b3271e206d7f',
                subdomains: ['a', 'b', 'c'],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: Image.asset('assets/images/${currentlayer}.png',
                fit: BoxFit.fitWidth),
          ),
        ),
      ]),
    );
  }
}
