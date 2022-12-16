import 'package:KnowWeather/widgets/bottombar.dart';
import 'package:KnowWeather/widgets/lunarphase.dart';
import 'package:KnowWeather/widgets/sunrisesunset.dart';
import 'package:KnowWeather/widgets/tempdisplay.dart';
import 'package:flutter/material.dart';
import '../widgets/drawer_scree.dart';
import 'package:provider/provider.dart';
import '../providers/citylist.dart';
import '../widgets/wind_pressure.dart';

class Dailyforecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<CityList>(context).forecast;

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Daily Forecast"),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(data[0].imageurl), fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height * 0.88,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (ctx, i) => Center(
            child: SingleChildScrollView(
              child: Card(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.height * 0.47,
                        child: CurrentTemp(data[i], 1)),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.height * 0.30,
                        child: Windpressure(data[i], 1)),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: SunMoonRise(data[i], 1)),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: LunarPhase(data[i])),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Bottombar(2),
    );
  }
}
