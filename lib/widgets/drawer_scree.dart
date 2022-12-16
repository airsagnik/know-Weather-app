import 'package:KnowWeather/providers/citylist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    var k = [];
    var citydata = Provider.of<CityList>(context).cities;
    citydata.forEach((key, value) {
      k.add(key);
    });

    return Drawer(
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                height: MediaQuery.of(context).size.height * 0.41,
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black54),
                  child: Text(
                    'Know Weather App',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/cloudimages.jpg'),
                  ),
                  color: Colors.yellow,
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: Consumer<CityList>(
                    builder: (ctx, snap, ch) => ListView.builder(
                      itemBuilder: (ctx, i) => Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.purple),
                        child: ListTile(
                          onTap: () async {
                            BuildContext loading;
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  loading = ctx;
                                  return AlertDialog(
                                    content: Container(
                                        alignment: Alignment.center,
                                        height: 100,
                                        width: 200,
                                        child: CircularProgressIndicator()),
                                    title: Text("Please wait"),
                                  );
                                });

                            Provider.of<CityList>(context, listen: false)
                                .addcity(snap.infocity.keys.toList()[i])
                                .then((value) {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushReplacementNamed('/weather');
                            }).catchError((error) {
                              Navigator.of(loading).pop();
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: Text("Error"),
                                        content: Text("Some Error Occured!"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("ok!"))
                                        ],
                                      ));
                              return;
                            });
                          },
                          leading: Icon(
                            Icons.location_city,
                            color: Colors.orange,
                          ),
                          title: Text(
                            k[i],
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                      itemCount: snap.infocity.keys.length,
                    ),
                  )),
              Text(
                "Powered by OpenWeather Api",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                "Powered by Leaflet Maps",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text("Developed by air_sagnik"),
            ]),
      ),
    );
  }
}
