import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../models/city.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class CurrentTemp extends StatelessWidget {
  City citydata;
  int a;
  CurrentTemp(this.citydata, this.a);

  @override
  Widget build(BuildContext context) {
    var min = citydata.min - 273;
    var max = citydata.max - 273;
    var temp = citydata.temperature - 273;
    var morning;
    var night;
    if (a == 1) {
      morning = citydata.daytemp - 273;
      night = citydata.nighttemp - 273;
    }
    var feelslike = citydata.feelslike - 273;
    var t = a == 0
        ? DateTime.now().toUtc().millisecondsSinceEpoch
        : citydata.time * 1000;
    print(t);
    var t2 = DateFormat('dd/MM/yyyy HH:mm').format(
        DateTime.fromMillisecondsSinceEpoch(t + (citydata.timezone * 1000),
            isUtc: true));
    print(t2);
    return Card(
      color: Colors.black54,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              citydata.name,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(t2.toString(), style: TextStyle(color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (a == 0)
                            Text(
                              '${temp.toStringAsFixed(0)}\u00b0C',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          if (a == 1)
                            Row(
                              children: [
                                Icon(
                                  WeatherIcons.day_sunny,
                                  color: Colors.white,
                                ),
                                Text(
                                  '${morning.toStringAsFixed(0)}',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '\u00b0C',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(WeatherIcons.moon_alt_waning_crescent_1,
                                    color: Colors.white),
                                Text(
                                  '${night.toStringAsFixed(0)}',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '\u00b0C',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            citydata.description,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ])),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white54),
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Image.network(
                      'https://openweathermap.org/img/wn/${citydata.iconid.toString()}@2x.png',
                    )),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                    Text(
                      max.toStringAsFixed(0),
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                    ),
                    Text(min.toStringAsFixed(0),
                        style: TextStyle(color: Colors.white))
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.cloud, color: Colors.white),
                    SizedBox(
                      width: 2,
                    ),
                    Text("%",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 2,
                    ),
                    Text(citydata.cloud.toString(),
                        style: TextStyle(color: Colors.white))
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      WeatherIcons.humidity,
                      color: Colors.white,
                    ),
                    Text(
                      citydata.humidity.toStringAsFixed(0),
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Icon(
                      Icons.visibility,
                      color: Colors.white,
                    ),
                    Text(citydata.visibility.toStringAsFixed(0) + " m",
                        style: TextStyle(color: Colors.white, fontSize: 22))
                  ],
                ),
                Row(
                  children: [
                    Icon(WeatherIcons.thermometer, color: Colors.white),
                    SizedBox(
                      width: 2,
                    ),
                    Text('\u00b0C',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 2,
                    ),
                    Text(feelslike.toStringAsFixed(0),
                        style: TextStyle(color: Colors.white))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            if (a == 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        WeatherIcons.raindrop,
                        color: Colors.white,
                      ),
                      Text(
                        (citydata.rainprobability * 100).toStringAsFixed(0) +
                            "%",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Rain',
                          style: TextStyle(color: Colors.white, fontSize: 22))
                    ],
                  ),
                  Row(
                    children: [
                      Icon(WeatherIcons.rain_mix, color: Colors.white),
                      SizedBox(
                        width: 2,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                          citydata.rainquantity != null
                              ? citydata.rainquantity.toStringAsFixed(0)
                              : "0" + "mm",
                          style: TextStyle(color: Colors.white))
                    ],
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
