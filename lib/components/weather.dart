// https://api.weatherapi.com/v1/current.json?key=6b081befe6f744f2a5692158242307&q=Taal&aqi=no
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:save2woproj/components/card.dart';


class WeatherCard extends StatefulWidget {
  @override
  State<WeatherCard> createState() => StateWeatherCard();
}

class StateWeatherCard extends State<WeatherCard> {
  Future<Weather?>? _weather;
  @override
  void initState() {
    super.initState();
    _weather = fetchData();
  }

  Future<Weather> fetchData() async {
    try {
      final uri = Uri.https(
        'save2wo-api.vercel.app',
        '/weather',
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Weather w = Weather.fromJson(data);
        return w;
      } else {
        throw Exception('Couldn\'t get Weather 1');
      }
    } catch (e) {
      rethrow;
    }
  }

  Widget buildDataWidget(context, snapshot,size) => Container(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Container(
                width: size.width,
                height: 200,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 215, 239, 245),
                        Color(0xFF37B7C3),
                        Color(0xFF088395),
                        Color(0xFF071952)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: const Color(0xFF83B4FF), //36C2CE
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF83B4FF).withOpacity(0.5),
                        spreadRadius: -12,
                        blurRadius: 10,
                        offset: const Offset(0, 25),
                      ),
                    ]),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Image.network(
                        'https:${snapshot.data.current.condition.icon}',
                      ),
                    ),
                     Positioned(
                        top: 70,
                        left: 20,
                        child: Text('${snapshot.data.current.condition.text}',
                            style:
                                const TextStyle(color: Colors.white, fontSize: 20)
                                )),
                                Positioned(
                       bottom: 30,
                        left: 20,
                        child: Text('${snapshot.data.location.name}, ${snapshot.data.location.region}',
                            style:
                                const TextStyle(color: Colors.white, fontSize: 40)
                                )),
                     Positioned(
                        top: 20,
                        right: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text('${snapshot.data.current.tempC}°C',
                                    style: TextStyle(
                                        fontSize:size.width < 800 ? size.width * 0.1 : 80,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                        //foreground: Paint()..shader = linearGradient,

                                        ))),
                                        
                          ],
                        )),
                  ],
                )),
          ),
        );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  LoadingCard(width: size.width, height: 200, scale: Scale(heightPercent: 0.22,widthPercent: 1));
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Container();
          } else {
            if (snapshot.hasData) {
              return buildDataWidget(context, snapshot,size);
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("${snapshot.error}");
            } else {
              return Container();
            }
          }
        });
  }
}
class Weather {
  Location? location;
  Current? current;
  Forecast? forecast;

  Weather({this.location, this.current, this.forecast});

  Weather.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    forecast = json['forecast'] != null
        ? new Forecast.fromJson(json['forecast'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    if (this.forecast != null) {
      data['forecast'] = this.forecast!.toJson();
    }
    return data;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  num? lat;
  num? lon;
  String? tzId;
  num? localtimeEpoch;
  String? localtime;

  Location(
      {this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      this.tzId,
      this.localtimeEpoch,
      this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    tzId = json['tz_id'];
    localtimeEpoch = json['localtime_epoch'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['region'] = this.region;
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['tz_id'] = this.tzId;
    data['localtime_epoch'] = this.localtimeEpoch;
    data['localtime'] = this.localtime;
    return data;
  }
}

class Current {
  num? lastUpdatedEpoch;
  String? lastUpdated;
  num? tempC;
  num? isDay;
  Condition? condition;
  num? humidity;
  num? cloud;
  num? windchillC;
  num? heatindexC;
  num? dewpointC;
  num? uv;

  Current(
      {this.lastUpdatedEpoch,
      this.lastUpdated,
      this.tempC,
      this.isDay,
      this.condition,
      this.humidity,
      this.cloud,
      this.windchillC,
      this.heatindexC,
      this.dewpointC,
      this.uv});

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdatedEpoch = json['last_updated_epoch'];
    lastUpdated = json['last_updated'];
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    humidity = json['humidity'];
    cloud = json['cloud'];
    windchillC = json['windchill_c'];
    heatindexC = json['heatindex_c'];
    dewpointC = json['dewpoint_c'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_updated_epoch'] = this.lastUpdatedEpoch;
    data['last_updated'] = this.lastUpdated;
    data['temp_c'] = this.tempC;
    data['is_day'] = this.isDay;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['humidity'] = this.humidity;
    data['cloud'] = this.cloud;
    data['windchill_c'] = this.windchillC;
    data['heatindex_c'] = this.heatindexC;
    data['dewpoint_c'] = this.dewpointC;
    data['uv'] = this.uv;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  num? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['icon'] = this.icon;
    data['code'] = this.code;
    return data;
  }
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <Forecastday>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(new Forecastday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forecastday != null) {
      data['forecastday'] = this.forecastday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Forecastday {
  String? date;
  num? dateEpoch;
  Day? day;

  Forecastday({this.date, this.dateEpoch, this.day});

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateEpoch = json['date_epoch'];
    day = json['day'] != null ? new Day.fromJson(json['day']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['date_epoch'] = this.dateEpoch;
    if (this.day != null) {
      data['day'] = this.day!.toJson();
    }
    return data;
  }
}

class Day {
  num? maxtempC;
  num? mintempC;
  num? avgtempC;
  num? maxwindKph;
  num? totalprecipMm;
  num? avgvisKm;
  num? dailyWillItRain;
  num? dailyChanceOfRain;
  Condition? condition;

  Day(
      {this.maxtempC,
      this.mintempC,
      this.avgtempC,
      this.maxwindKph,
      this.totalprecipMm,
      this.avgvisKm,
      this.dailyWillItRain,
      this.dailyChanceOfRain,
      this.condition});

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    avgtempC = json['avgtemp_c'];
    maxwindKph = json['maxwind_kph'];
    totalprecipMm = json['totalprecip_mm'];
    avgvisKm = json['avgvis_km'];
    dailyWillItRain = json['daily_will_it_rain'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxtemp_c'] = this.maxtempC;
    data['mintemp_c'] = this.mintempC;
    data['avgtemp_c'] = this.avgtempC;
    data['maxwind_kph'] = this.maxwindKph;
    data['totalprecip_mm'] = this.totalprecipMm;
    data['avgvis_km'] = this.avgvisKm;
    data['daily_will_it_rain'] = this.dailyWillItRain;
    data['daily_chance_of_rain'] = this.dailyChanceOfRain;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    return data;
  }
}
