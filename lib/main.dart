import 'package:KnowWeather/Screens/daily_forcast.dart';
import 'package:KnowWeather/Screens/hourly_forecast.dart';
import 'package:KnowWeather/Screens/mapdisplay.dart';
import 'package:KnowWeather/Screens/waitingscreen.dart';
import 'package:KnowWeather/helpers/dbhelper.dart';
import 'package:flutter/material.dart';
import './Screens/conciseWeather.dart';
import 'package:provider/provider.dart';
import './providers/citylist.dart';
import './Screens/findcity.dart';

void main() {
  runApp(MyApp());
}

int flag = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (ctx) => CityList())],
        child: Consumer<CityList>(
          builder: (ctx, d, ch) => MaterialApp(
            home: flag == 0 ? Homepage() : Homepage2(),
            routes: {
              '/addcity': (ctx) => Addcity(),
              '/weather': (ctx) => WeatherDeatals(),
              '/dailyforecast': (ctx) => Dailyforecast(),
              '/hourlyforecast': (ctx) => Hourlyforecast(),
              '/maps': (ctx) => Mapdisplay(),
            },
          ),
        ));
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    flag = 1;
    return FutureBuilder(
        future: DBhelper.fetchdata("cities"),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Waiting();
          }
          if (snapshot.hasData) {
            List<String> citynames = [];
            List<Map<String, dynamic>> dt = snapshot.data;
            print("inside main");
            print(dt);
            if (dt.isEmpty) {
              return Addcity();
            }
            dt.forEach((element) {
              citynames.add(element['name']);
              Provider.of<CityList>(context, listen: false)
                  .initialisecities(element['name'], int.parse(element['id']));
            });

            Future.wait([
              Provider.of<CityList>(context, listen: false)
                  .addcity(citynames[0])
                  .then((value) {
                return WeatherDeatals();
              })
            ]);
            return Waiting();
          } else {
            return Addcity();
          }
        });

    /*return Provider.of<CityList>(context, listen: false).cities.isEmpty == true
        ? Addcity()
        : WeatherDeatals();*/
  }
}

class Homepage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<CityList>(context, listen: false).cities.isEmpty == true
        ? Addcity()
        : WeatherDeatals();
  }
}
