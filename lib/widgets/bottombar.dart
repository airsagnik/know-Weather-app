import 'package:flutter/material.dart';

class Bottombar extends StatefulWidget {
  int pos;
  Bottombar(this.pos);

  @override
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int currval;

  @override
  void initState() {
    super.initState();
    setState(() {
      currval = widget.pos;
    });
  }

  void taponbar(int index) {
    setState(() {
      currval = index;
    });
    print(index);

    if (index == 1) {
      Navigator.of(context).pushReplacementNamed('/hourlyforecast');
    } else if (index == 2) {
      Navigator.of(context).pushReplacementNamed('/dailyforecast');
    } else if (index == 0) {
      Navigator.of(context).pushReplacementNamed('/weather');
    } else if (index == 3) {
      Navigator.of(context).pushNamed('/maps');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: taponbar,
        currentIndex: currval,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        selectedFontSize: 15,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.cloud_circle),
              label: 'Current'),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.hourglass_empty),
              label: 'Hourly forecast'),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.view_day),
              label: 'Daily Forecast'),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.map),
              label: 'Maps'),
        ]);
  }
}
