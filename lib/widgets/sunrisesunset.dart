import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../models/city.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SunMoonRise extends StatelessWidget {
  City citydata;
  int a;
  SunMoonRise(this.citydata, this.a);
  @override
  Widget build(BuildContext context) {
    print(DateTime.now().toUtc().millisecondsSinceEpoch / 1000);
    double sliderval =
        (DateTime.now().toUtc().millisecondsSinceEpoch + 0.1) / 1000;

    final sr = DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
        citydata.sunrise * 1000 + citydata.timezone * 1000,
        isUtc: true));
    print(sr);
    final ss = DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
        citydata.sunset * 1000 + citydata.timezone * 1000,
        isUtc: true));
    print(ss);
    return Card(
      color: Colors.black54,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                WeatherIcons.sunrise,
                color: Colors.white,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                a == 0
                    ? sr.toString()
                    : DateFormat("HH:mm")
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            citydata.sunrise * 1000 + citydata.timezone * 1000,
                            isUtc: true))
                        .toString(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )
            ]),
          ),
          if (a == 0)
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width * 0.65,
              child: SliderTheme(
                data: SliderThemeData(
                    thumbShape: RoundSliderThumbShape(disabledThumbRadius: 20),
                    trackHeight: 40,
                    activeTrackColor: Colors.red,
                    disabledInactiveTrackColor: Colors.red,
                    disabledActiveTrackColor: Colors.purple,
                    disabledThumbColor: Colors.yellow),
                child: Slider(
                  activeColor: Colors.red,
                  value: sliderval < citydata.sunset + 0.1 &&
                          sliderval > citydata.sunrise
                      ? sliderval
                      : citydata.sunset + 0.1,
                  min: citydata.sunrise + 0.1,
                  max: citydata.sunset + 0.1,
                  label: "hi",
                  onChanged: null,
                ),
              ),
            ),
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                WeatherIcons.sunset,
                color: Colors.white,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                a == 0
                    ? ss.toString()
                    : DateFormat("HH:mm")
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            citydata.sunset * 1000 + citydata.timezone * 1000,
                            isUtc: true))
                        .toString(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )
            ]),
          ),
          if (a == 1)
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      WeatherIcons.moonrise,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      DateFormat("HH:mm")
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              citydata.moonrise * 1000 +
                                  citydata.timezone * 1000,
                              isUtc: true))
                          .toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  ]),
            ),
          if (a == 1)
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      WeatherIcons.moonset,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      DateFormat("HH:mm")
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              citydata.moonset * 1000 +
                                  citydata.timezone * 1000,
                              isUtc: true))
                          .toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  ]),
            )
        ]),
      ),
    );
  }
}
/*Container(
          constraints: BoxConstraints(maxHeight: 100),
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
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
                    value: 2,
                    cornerStyle: CornerStyle.bothCurve,
                    width: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
              ),
            ],
          ),
        )*/
