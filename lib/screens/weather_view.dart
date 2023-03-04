// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
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
  final today = DateTime.now(); //EEEE, MMMMd MMMM

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
      backgroundColor: yellowColor,
      body: SafeArea(
        top: true,
        child: RefreshIndicator(
          color: yellowColor,
          backgroundColor: Colors.black,
          onRefresh: getWeather,
          child: ListView(
            padding: EdgeInsets.symmetric(
              vertical: 80.0,
              horizontal: 15.0,
            ),
            children: [
              Expanded(
                child: FutureBuilder(
                  future: getWeather(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Couldn't fetch data",
                          style: TextStyle(
                            fontFamily: 'TiltNeon',
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${snapshot.data!.location!.name}, ',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'TiltNeon',
                                  color: blackColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data!.location!.region}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'TiltNeon',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            height: 40.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Text(
                                DateFormat.MMMEd().format(today),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'TiltNeon',
                                  color: yellowColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            '${snapshot.data!.current!.condition!.text}',
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'TiltNeon',
                              color: blackColor,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data!.current!.tempC}',
                                style: TextStyle(
                                  fontSize: 150.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'TiltNeon',
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 25.0, 0.0, 0.0),
                                child: Text(
                                  'O',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'TiltNeon',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 28.0),
                                child: Text(
                                  'C',
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'TiltNeon',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          Container(
                            height: 150.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AdditionalInfoCard(
                                    value:
                                        '${snapshot.data!.current!.windKph} km/h',
                                    iconValue: Icons.wind_power_outlined,
                                    name: 'Wind',
                                  ),
                                  AdditionalInfoCard(
                                    value:
                                        '${snapshot.data!.current!.humidity}%',
                                    iconValue: Icons.water_drop_outlined,
                                    name: 'Humidity',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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