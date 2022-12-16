import 'dart:io';

import 'package:KnowWeather/providers/citylist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowCity extends StatefulWidget {
  final name;
  ShowCity({this.name});

  @override
  _ShowCityState createState() => _ShowCityState();
}

class _ShowCityState extends State<ShowCity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.purple, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () async {
            try {
              await Provider.of<CityList>(context, listen: false)
                  .addcity(widget.name);
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
          title: Text(widget.name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: () async {
                var goahead = false;
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Text("Delete"),
                          content: Text(
                              "Do you want to delete city: ${widget.name}"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text("Yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text("No")),
                          ],
                        )).then((value) async {
                  goahead = value;
                  if (goahead == false) {
                    return;
                  }
                  if (widget.name ==
                      Provider.of<CityList>(context, listen: false)
                          .cityrequested) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "You cannot delete this as it is currently selected!")));
                    return;
                  }
                  print("delete");
                  var mp = Provider.of<CityList>(context, listen: false).cities;
                  int id = mp[widget.name].id;
                  await Provider.of<CityList>(context, listen: false)
                      .deletecity(widget.name, id);
                });
              }),
        ),
      ),
    );
  }
}
