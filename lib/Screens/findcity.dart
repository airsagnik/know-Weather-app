import 'dart:io';

import 'package:KnowWeather/widgets/drawer_scree.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../providers/citylist.dart';
import '../widgets/showCity.dart';
import "package:strings/strings.dart";

class Addcity extends StatefulWidget {
  @override
  _AddcityState createState() => _AddcityState();
}

class _AddcityState extends State<Addcity> {
  final cityname = TextEditingController();
  double lat;
  double lon;

  Future<void> userloc() async {
    var obj = await Location.instance.getLocation();
    lat = obj.latitude;
    lon = obj.longitude;
    var name = await Provider.of<CityList>(context, listen: false)
        .getnameofloc(lat, lon);
    await Provider.of<CityList>(context, listen: false).addcity(name);
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var lst = Provider.of<CityList>(context);
    var citylist = [];
    lst.infocity.forEach((key, value) {
      citylist.add(key);
      print(key);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Add city'),
        //actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.purple)),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  onSubmitted: (value) async {
                    print(value);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Please wait while we fetch your data!")));
                    try {
                      await lst.addcity(capitalize(value));
                    } on HttpException catch (error) {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text("Error"),
                                content: Text(error.message),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("ok!"))
                                ],
                              ));
                      return;
                    } catch (error) {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text("Error"),
                                content: Text("Some error occured"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("ok!"))
                                ],
                              ));
                      return;
                    }
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                  controller: cityname,
                  decoration: InputDecoration(labelText: '  Enter city name'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: Text(
                    "Location",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    await userloc();
                  },
                ),
              ),
            ),
            citylist.isEmpty == true
                ? Center(
                    child: Text('Add Cities'),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: ListView.builder(
                        itemBuilder: (ctx, i) {
                          return ShowCity(name: citylist[i]);
                        },
                        itemCount: citylist.length),
                  ),
          ],
        ),
      ),
    );
  }
}

/*class Search extends SearchDelegate<String> {
  var selectedcity = "";
  var citylist = [];
  var history = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    selectedcity = query;
    print(selectedcity);
    var lst = Provider.of<CityList>(context, listen: false);
    lst.addcity(selectedcity);
    Navigator.of(context).pop();
    return Center(
      child: Text(selectedcity),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestionlist = query.isEmpty
        ? history
        : citylist
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (ctx, i) => ListTile(
        onTap: () {
          selectedcity = query;
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: Text(suggestionlist[i]),
      ),
      itemCount: suggestionlist.length,
    );
  }
}*/
