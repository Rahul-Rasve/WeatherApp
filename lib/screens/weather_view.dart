// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/components/additional_info.dart';
import 'package:weather_app/components/city_name.dart';
import 'package:weather_app/components/date_display.dart';
import 'package:weather_app/components/temperature_display.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/additional_info_card.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final today = DateTime.now();
  String? city = '';

  Future<WeatherModel> getWeather() async {
    final response = await http.get(
      Uri.parse(
        'https://weatherapi-com.p.rapidapi.com/current.json?q=$city&rapidapi-key=[yourAPIkey]',
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
  TextEditingController? cityController;

  @override
  void initState() {
    myWeather = getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 40.0,
            horizontal: 15.0,
          ),
          child: Column(
            children: [
              SizedBox(
                width: 350.0,
                child: TextField(
                  enableInteractiveSelection: true,
                  onSubmitted: (value) {
                    setState(() {
                      city = value;
                      FocusScope.of(context).unfocus();
                    });
                  },
                  controller: cityController,
                  cursorColor: blackColor,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter City',
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: blackColor,
                      size: 35.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: blackColor,
                        width: 4.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: blackColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: FutureBuilder(
                  future: getWeather(),
                  builder: ((context, snapshot) {
                    if (city == '') {
                      return Center(
                        child: Text(
                          'Search for a City',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w700,
                            color: blackColor,
                          ),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Couldn't fetch data,\nTry correcting City name\nor check Network Connection.",
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w700,
                            color: blackColor,
                          ),
                        ),
                      );
                    } else {
                      return RefreshIndicator(
                        color: yellowColor,
                        backgroundColor: Colors.black,
                        onRefresh: getWeather,
                        child: ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CityName(
                                  cityName: '${snapshot.data!.location!.name}',
                                  countryName:
                                      '${snapshot.data!.location!.country}',
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                DateDisplay(
                                  today: today,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  '${snapshot.data!.current!.condition!.text}',
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w600,
                                    color: blackColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TemperatureDisplay(
                                  tempC: '${snapshot.data!.current!.tempC}',
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                AdditionalInfo(
                                  windValue:
                                      '${snapshot.data!.current!.windKph}',
                                  humidityValue:
                                      '${snapshot.data!.current!.humidity}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
