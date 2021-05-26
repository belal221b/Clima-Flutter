import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temp;
  String weatherIcon;
  String message;
  String city;
  var backgroungImage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temp = 0;
      weatherIcon = 'ERROR';
      message = 'UNABLE TO GET WEATHER DATA';
      city = '';
      backgroungImage = 'location_background';
    }
    temp = weatherData['main']['temp'].toInt();

    message = weather.getMessage(temp);
    int weatherId = weatherData['weather'][0]['id'];
    weatherIcon = weather.getWeatherIcon(weatherId);
    // print(weatherId);
    city = 'in ${weatherData['name']}';
    backgroungImage = weather.getBackgroundImage(temp);

    print(temp);
    print(weatherId);
    print(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/${backgroungImage.toString()}.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          var weatherData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CityScreen();
                              },
                            ),
                          );
                          setState(() {
                            if (weatherData != null) {
                              print(weatherData);
                              updateUI(weatherData);
                            }
                          });
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 100.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temp° ',
                          style: kTempTextStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text(
                            weatherIcon,
                            style: kConditionTextStyle,
                            // textAlign: TextAlign.,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      bottom: 60,
                    ),
                    child: Text(
                      "$message $city",
                      textAlign: TextAlign.left,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // SizedBox(
          //   height: 100.0,
          // ),
        ),
      ),
    );
  }
}

// var temp = jsonDecode(data)['main']['temp'];
// print(temp);
// var weatherId = jsonDecode(data)['weather'][0]['id'];
// print(weatherId);
// var city = jsonDecode(data)['name'];
// print(city);
