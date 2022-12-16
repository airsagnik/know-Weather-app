import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../models/city.dart';

class Windpressure extends StatelessWidget {
  City citydata;
  int a;
  Windpressure(this.citydata, this.a);
  @override
  Widget build(BuildContext context) {
    var dewt = citydata.dewpoint - 273;
    return Card(
      color: Colors.black54,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white60),
                  child: Image.asset(
                    'assets/images/windmill.png',
                    color: Colors.black,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Text(
                        citydata.degree.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(citydata.windspeed.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      SizedBox(
                        height: 5,
                      ),
                      Text('m/s',
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ]),
                    SizedBox(
                      height: 6,
                    ),
                    Column(children: [
                      Text('UV index',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text(citydata.uvi.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ])
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 1,
            color: Colors.white,
            height: a == 1
                ? MediaQuery.of(context).size.height * 0.30
                : MediaQuery.of(context).size.height * 0.30,
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
                      Text('Pressure',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      SizedBox(
                        height: 5,
                      ),
                      Icon(
                        WeatherIcons.barometer,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(citydata.pressure.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text("hPa",
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ]),
                    SizedBox(
                      height: 6,
                    ),
                    Column(children: [
                      Text('Dew point',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text(dewt.toStringAsFixed(0) + "\u00b0C",
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ])
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
