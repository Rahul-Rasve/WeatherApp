// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/components/additional_info.dart';
import 'package:weather_app/components/city_name.dart';
import 'package:weather_app/components/date_display.dart';
import 'package:weather_app/components/temperature_display.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final today = DateTime.now();
  String? city = '';

  Future<bool> requestLocationPermission() async {
    PermissionStatus permission = await Permission.location.request();
    return permission == PermissionStatus.granted;
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  Future<String> getCityName(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String cityName = placemark.locality!;
      return cityName;
    }
    return "Unknown";
  }

  void getLocationAndCityName() async {
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      Position position = await getCurrentLocation();
      String cityName = await getCityName(position);
      setState(() {
        city = cityName;
      });
      debugPrint('City Name: $cityName');
    } else {
      debugPrint('Location permission not granted');
    }
  }

  Future<WeatherModel> getWeather() async {
    final response = await http.get(
      Uri.parse(
        'https://weatherapi-com.p.rapidapi.com/current.json?q=$city&rapidapi-key=[Your-API-Key]',
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

  @override
  void initState() {
    super.initState();
    getLocationAndCityName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 15.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    alignment: Alignment.topLeft,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 45.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: FutureBuilder(
                  future: getWeather(),
                  builder: ((context, snapshot) {
                    if (city == '') {
                      //on empty search field
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
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
                      //error handling
                      return Center(
                        child: Text(
                          """Couldn't fetch data,\nTry correcting City name\nor check Network Connection.""",
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
                      //successful fetch
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
