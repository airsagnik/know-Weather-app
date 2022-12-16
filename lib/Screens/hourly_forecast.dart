import 'package:KnowWeather/widgets/bottombar.dart';
import 'package:KnowWeather/widgets/drawer_scree.dart';
import 'package:flutter/material.dart';
import '../widgets/hourlyforecast.dart';
import '../providers/citylist.dart';
import 'package:provider/provider.dart';

class Hourlyforecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<CityList>(context).hourlyforecast;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Hourly Forecast"),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(data[0].imageurl), fit: BoxFit.cover)),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (ctx, i) => ForecastHour(data[i]),
          )),
      bottomNavigationBar: Bottombar(1),
    );
  }
}
