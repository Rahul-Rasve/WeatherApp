// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<WeatherModel> getWeather() async {
    final response = await http.get(
      Uri.parse(
        'https://weatherapi-com.p.rapidapi.com/current.json?q=Pune&rapidapi-key=95f7037016msh850a5f58bc3afb7p1f4bb3jsnfd374fab7e65',
      ),
    );

    var data = response.body.toString();

    if (response.statusCode == 200) {
      Map<String, dynamic> weatherApi = jsonDecode(data);
      return WeatherModel.fromJson(weatherApi);
    } else {
      throw Exception('Could not fetch data.');
    }
  }

  late Future<WeatherModel> myWeather;

  @override
  void initState() {
    myWeather = getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
        child: SafeArea(
          top: true,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.menu,
                    color: greyColor,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder<WeatherModel>(
                future: getWeather(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        // 'Could not fetch data...',
                        snapshot.error.toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data!.location!.name.toString(),
                          style: TextStyle(
                            fontSize: 30.0,
                            color: greyColor,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          snapshot.data!.current!.condition!.text.toString(),
                          style: TextStyle(
                            fontSize: 35.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
