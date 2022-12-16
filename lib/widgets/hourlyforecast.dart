import 'package:KnowWeather/Screens/hourly_forecast.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../models/hourlyweather.dart';
import 'package:intl/intl.dart';

class ForecastHour extends StatelessWidget {
  Hourlyweather citydata;
  ForecastHour(this.citydata);
  @override
  Widget build(BuildContext context) {
    var fl = citydata.feelslike - 273;
    var t = citydata.temp - 273;
    var dwpt = citydata.dewpoint - 273;
    var tm = DateFormat("dd/MM HH:mm").format(
        DateTime.fromMillisecondsSinceEpoch(
            citydata.time * 1000 + citydata.timezone * 1000,
            isUtc: true));
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tm.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white54),
                    child: Image.network(
                        'https://openweathermap.org/img/wn/${citydata.iconid.toString()}@2x.png')),
                SizedBox(
                  height: 10,
                ),
                Text(
                  (t.toStringAsFixed(0) + " \u00b0C"),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(citydata.description.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25)),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      WeatherIcons.rain_mix,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text((citydata.probofrain * 100).toStringAsFixed(2) + " %",
                        style: TextStyle(color: Colors.white, fontSize: 25))
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width * 0.45,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(
                  WeatherIcons.day_sunny,
                  color: Colors.white,
                ),
                Text(fl.toStringAsFixed(0) + " \u00b0C",
                    style: TextStyle(color: Colors.white, fontSize: 25)),
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(WeatherIcons.barometer, color: Colors.white),
                Text(citydata.pressure.toStringAsFixed(0) + " hPa",
                    style: TextStyle(color: Colors.white, fontSize: 25))
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(WeatherIcons.humidity, color: Colors.white),
                Text(citydata.humidity.toStringAsFixed(0),
                    style: TextStyle(color: Colors.white, fontSize: 25))
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(WeatherIcons.raindrops, color: Colors.white),
                Text((dwpt + 0.0).toStringAsFixed(2) + "\u00b0C",
                    style: TextStyle(color: Colors.white, fontSize: 25))
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(WeatherIcons.day_sunny, color: Colors.white),
                Text(citydata.uvi.toStringAsFixed(2),
                    style: TextStyle(color: Colors.white, fontSize: 25))
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(WeatherIcons.cloud, color: Colors.white),
                Text(citydata.cloud.toString() + "%",
                    style: TextStyle(color: Colors.white, fontSize: 25))
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(Icons.visibility, color: Colors.white),
                Text(citydata.visibility.toString() + " m",
                    style: TextStyle(color: Colors.white, fontSize: 25))
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(WeatherIcons.wind, color: Colors.white),
                Text(citydata.windspeed.toString() + "m/s",
                    style: TextStyle(color: Colors.white, fontSize: 25))
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(WeatherIcons.direction_up, color: Colors.white),
                Text(citydata.deg.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 25))
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}
