import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../models/city.dart';

class LunarPhase extends StatelessWidget {
  City citydata;
  LunarPhase(this.citydata);
  Icon obj;
  String moonphase(double val) {
    if (val == 0 || val == 1) {
      obj = Icon(WeatherIcons.moon_new, color: Colors.white);
      return "New Moon";
    } else if (val == 0.25) {
      obj = Icon(WeatherIcons.moon_first_quarter, color: Colors.white);
      return "First Quarter Moon";
    } else if (val == 0.5) {
      obj = Icon(WeatherIcons.moon_full, color: Colors.white);
      return "Full Moon";
    } else if (val == 0.75) {
      obj = Icon(WeatherIcons.moon_third_quarter, color: Colors.white);
      return "Last Quarter Moon";
    } else if (val > 0 && val < 0.25) {
      obj = Icon(WeatherIcons.moon_waxing_crescent_1, color: Colors.white);
      return "Waxing Crescent";
    } else if (val > 0.25 && val < 0.5) {
      obj = Icon(WeatherIcons.moon_waxing_gibbous_1, color: Colors.white);
      return "Waxing Gibous";
    } else if (val > 0.5 && val < 0.75) {
      {
        obj = Icon(WeatherIcons.moon_waning_gibbous_1, color: Colors.white);
        return "Waning Gibous";
      }
    } else {
      obj = Icon(WeatherIcons.moon_waning_crescent_1, color: Colors.white);
      return "Waning Crescent";
    }
  }

  @override
  Widget build(BuildContext context) {
    double a = citydata.moonphase + 0.0;
    String str = moonphase(a);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ListTile(
        tileColor: Colors.black54,
        leading: obj,
        title: Text('Lunar Phase',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        trailing: Text(str,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
