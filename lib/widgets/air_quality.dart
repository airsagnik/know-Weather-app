import 'package:KnowWeather/models/city.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

enum Quality { Good, Fair, Moderate, Poor, Very_Poor }

class AirQuality extends StatelessWidget {
  City citydata;
  AirQuality(this.citydata);

  @override
  Widget build(BuildContext context) {
    print(citydata.aqi);
    double val;
    var textdis;
    if (citydata.aqi == 1.0) {
      textdis = 'Good';
      val = 1.0;
    } else if (citydata.aqi == 2.0) {
      textdis = 'Fair';
      val = 2.0;
    } else if (citydata.aqi == 3.0) {
      textdis = 'Moderate';
      val = 3.0;
    } else if (citydata.aqi == 4.0) {
      val = 4.0;
      textdis = 'Poor';
    } else {
      val = 5.0;
      textdis = 'Very Poor';
    }

    return Card(
      color: Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Text(
                            citydata.pm10.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          positionFactor: 0.1)
                    ],
                    minimum: 1.0,
                    maximum: 5.0,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: AxisLineStyle(
                        thickness: 0.2,
                        cornerStyle: CornerStyle.bothCurve,
                        color: Colors.blueAccent,
                        thicknessUnit: GaugeSizeUnit.factor),
                    pointers: <GaugePointer>[
                      RangePointer(
                        color: Colors.red,
                        value: val,
                        cornerStyle: CornerStyle.bothCurve,
                        width: 0.2,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(textdis, style: TextStyle(fontSize: 25)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Text(
                            citydata.pm25.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Text(
                            'PM2.5',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ]),
                        SizedBox(width: 5),
                        Column(children: [
                          Text(citydata.pm10.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          Text('PM10',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white))
                        ]),
                        SizedBox(width: 5),
                        Column(children: [
                          Text(citydata.co.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          Text('CO',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white))
                        ]),
                        SizedBox(width: 5),
                        Column(children: [
                          Text(citydata.no2.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          Text('NO2',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white))
                        ]),
                        SizedBox(width: 5),
                        Column(children: [
                          Text(citydata.so2.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          Text('So2',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white))
                        ]),
                        SizedBox(width: 5),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
