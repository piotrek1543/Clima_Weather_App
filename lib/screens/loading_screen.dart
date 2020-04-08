import 'package:climaweatherapp/services/location.dart';
import 'package:climaweatherapp/services/network_helper.dart';
import 'package:flutter/material.dart';

const String apiKey = 'b0f745b08e93733e0fd68303bd49aec2';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();

    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    double temperature = weatherData['main']['temp'];
    int condition = weatherData['weather'][0]['id'];
    String cityName = weatherData['name'];

    print(temperature);
    print(condition);
    print(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            print('Get Location Pressed!');
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
