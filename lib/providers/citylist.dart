import 'dart:io';

import 'package:KnowWeather/Screens/hourly_forecast.dart';
import 'package:KnowWeather/models/city.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/hourlyweather.dart';
import '../helpers/dbhelper.dart';

class CityList with ChangeNotifier {
  var cityrequested;
  City citydata;
  Map<String, City> infocity = {};
  List<City> forecast = [];
  List<Hourlyweather> hourlyforecast = [];

  Map<String, City> get cities {
    return {...infocity};
  }

  Future<void> deletecity(String name, int id) async {
    if (name == cityrequested) {
      return;
    }
    await DBhelper.delete("cities", id);
    infocity.removeWhere((key, value) => key == name);
    print(infocity['name']);
    notifyListeners();
  }

  void initialisecities(String name, int id) {
    infocity.putIfAbsent(name, () => City(id: id, name: name));
  }

  Future<String> getnameofloc(double lat, double lon) async {
    try {
      String lati = lat.toStringAsFixed(2);
      String longi = lon.toStringAsFixed(2);
      var url =
          'https://api.openweathermap.org/geo/1.0/reverse?lat=$lati&lon=$longi&limit=5&appid=f3662037848cf91e4960b3271e206d7f';
      var r = await http.get(url);
      print(url);
      var mp = json.decode(r.body) as List<dynamic>;
      return mp[0]['name'];
    } on HttpException catch (error) {
      throw error;
    } catch (error) {
      throw error;
    }
  }

  String converttodirection(int data) {
    if (data >= 348.75 || data <= 11.25)
      return 'N';
    else if (data > 11.25 && data <= 33.75)
      return 'NNE';
    else if (data > 33.75 && data <= 56.25)
      return 'NE';
    else if (data > 56.25 && data <= 78.75)
      return 'ENE';
    else if (data > 78.75 && data <= 101.25)
      return 'E';
    else if (data > 101.25 && data <= 123.75)
      return 'ESE';
    else if (data > 123.75 && data <= 146.25)
      return 'SE';
    else if (data > 146.25 && data <= 168.75)
      return 'SSE';
    else if (data > 168.75 && data <= 191.25)
      return 'S';
    else if (data > 191.25 && data <= 213.75)
      return 'SSW';
    else if (data > 213.75 && data <= 236.25)
      return 'SW';
    else if (data > 236.25 && data <= 258.75)
      return 'WSW';
    else if (data > 258.75 && data <= 281.25)
      return 'W';
    else if (data > 281.25 && data <= 303.75)
      return 'WNW';
    else if (data > 303.75 && data <= 326.25)
      return 'NW';
    else
      return 'NNW';
  }

  Future<void> addcity(String city) async {
    forecast = [];
    hourlyforecast = [];
    final apikey = 'f3662037848cf91e4960b3271e206d7f';
    try {
      var url =
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey';
      var response = await http.get(url);
      print(json.decode(response.body));
      var citydetails = json.decode(response.body) as Map<String, dynamic>;

      url =
          'https://api.openweathermap.org/data/2.5/air_pollution?lat=${citydetails['coord']['lat'].toString()}&lon=${citydetails['coord']['lon'].toString()}&appid=$apikey';
      var response2 = await http.get(url);
      print(json.decode(response2.body));
      var polldetails = json.decode(response2.body) as Map<String, dynamic>;
      var urlimage =
          'https://api.unsplash.com/search/photos?query=$city&client_id=Orln6KYe7hvGYU5-3fZFjjk1lGS2VFhTiiowFRH9Qmc';
      var imageresponse = await http.get(urlimage);
      var imageu = json.decode(imageresponse.body) as Map<String, dynamic>;
      print(imageu['results'][0]['urls']['full']);
      int deg = citydetails['wind']['deg'];
      String direction = converttodirection(deg);

      var foreurl =
          'https://api.openweathermap.org/data/2.5/onecall?lat=${citydetails['coord']['lat'].toString()}&lon=${citydetails['coord']['lon'].toString()}&exclude=minutely&appid=${apikey}';
      print(foreurl);
      var forecastresp = await http.get(foreurl);
      var foreresponse = json.decode(forecastresp.body) as Map<String, dynamic>;

      print("forecast");
      print(foreresponse);
      int i;
      for (i = 0; i <= 7; i++) {
        var mp = foreresponse['daily'][i];
        print(mp);
        int d = mp['wind_deg'];
        print(d);
        String direc = converttodirection(d);
        print(direc);
        City obj = City(
          imageurl: imageu['results'][0]['urls']['full'],
          name: citydetails['name'],
          time: mp['dt'],
          sunrise: mp['sunrise'],
          sunset: mp['sunset'],
          moonrise: mp['moonrise'],
          moonset: mp['moonset'],
          moonphase: mp['moon_phase'],
          daytemp: mp['temp']['day'],
          nighttemp: mp['temp']['night'],
          max: mp['temp']['max'],
          min: mp['temp']['min'],
          feelikeday: mp['feels_like']['day'],
          feelikenight: mp['feels_like']['night'],
          pressure: mp['pressure'],
          humidity: mp['humidity'],
          dewpoint: mp['dew_point'],
          windspeed: mp['wind_speed'],
          degree: direc,
          description: mp['weather'][0]['description'],
          iconid: mp['weather'][0]['icon'],
          cloud: mp['clouds'],
          uvi: mp['uvi'],
          rainquantity: mp['rain'],
          rainprobability: mp['pop'],
          snowprob: (mp['snow'] == null) ? null : mp['snow'],
          visibility: citydetails['visibility'],
          temperature: citydetails['main']['temp'],
          feelslike: citydetails['main']['feels_like'],
          timezone: citydetails['timezone'],
        );
        forecast.add(obj);
      }

      for (i = 0; i <= 47; i++) {
        var mp = foreresponse['hourly'][i];
        int d = mp['wind_deg'];
        print(d);
        String direc = converttodirection(d);
        Hourlyweather obj = Hourlyweather(
          imageurl: imageu['results'][0]['urls']['full'],
          cloud: mp['clouds'],
          timezone: citydetails['timezone'],
          name: citydetails['name'],
          time: mp['dt'],
          temp: mp['temp'],
          description: mp['weather'][0]['description'],
          dewpoint: mp['dew_point'],
          humidity: mp['humidity'],
          feelslike: mp['feels_like'],
          iconid: mp['weather'][0]['icon'],
          pressure: mp['pressure'],
          probofrain: mp['pop'] + 0.0,
          uvi: mp['uvi'] + 0.0,
          visibility: mp['visibility'],
          windspeed: mp['wind_speed'],
          deg: direc,
        );
        hourlyforecast.add(obj);
      }
      print(forecast);
      citydata = City(
          uvi: forecast[0].uvi,
          dewpoint: forecast[0].dewpoint,
          visibility: citydetails['visibility'],
          imageurl: imageu['results'][0]['urls']['full'],
          pm25: polldetails['list'][0]['components']['pm2_5'],
          pm10: polldetails['list'][0]['components']['pm10'],
          co: polldetails['list'][0]['components']['co'],
          no2: polldetails['list'][0]['components']['no2'],
          so2: polldetails['list'][0]['components']['so2'],
          aqi: polldetails['list'][0]['main']['aqi'],
          iconid: citydetails['weather'][0]['icon'],
          id: citydetails['id'],
          name: citydetails['name'],
          timezone: citydetails['timezone'],
          longitute: citydetails['coord']['lon'],
          latitude: citydetails['coord']['lat'],
          description: citydetails['weather'][0]['description'],
          temperature: citydetails['main']['temp'],
          feelslike: citydetails['main']['feels_like'],
          max: citydetails['main']['temp_max'],
          min: citydetails['main']['temp_min'],
          humidity: citydetails['main']['humidity'],
          pressure: citydetails['main']['pressure'],
          windspeed: citydetails['wind']['speed'],
          degree: direction,
          sunrise: citydetails['sys']['sunrise'],
          sunset: citydetails['sys']['sunset'],
          cloud: citydetails['clouds']['all'],
          country: citydetails['sys']['country']);

      if (infocity.containsKey(city)) {
        infocity.update(city, (value) => citydata);
        cityrequested = city;
      } else {
        infocity.putIfAbsent(city, () => citydata);
        cityrequested = city;
        await DBhelper.insert(
            "cities", {'id': citydata.id.toString(), 'name': city});
      }
      notifyListeners();
    } on HttpException catch (error) {
      throw error;
    } catch (error) {
      throw error;
    }
  }
}
