import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const kApiKey = '3ee627459c2b5673ae3a1ba450ddfea5';
const weatherApiStarter = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  int backgroungImage;

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$weatherApiStarter?q=$cityName&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    print(location.latitude);
    print(location.longitude);

    NetworkHelper networkHelper = NetworkHelper(
        '$weatherApiStarter?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String weatherCondition;
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌥️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ice-cream 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and shirts 👕';
    } else if (temp < 10) {
      return 'You\'ll need scarf 🧣 and gloves 🧤';
    } else {
      return 'Bring a jacket🧥 just in case';
    }
  }

  dynamic getBackgroundImage(int temp) {
    if (temp > 25) {
      return backgroungImage = 30;
    } else if (temp > 20) {
      return backgroungImage = 25;
    } else if (temp < 10) {
      return backgroungImage = 15;
    } else {
      return backgroungImage = -55;
    }
  }

  String getcondition(int temp) {
    if (temp > 25) {
      weatherCondition = 'super sunny';
    } else if (temp > 20) {
      weatherCondition = 'sunny';
    } else if (temp < 10) {
      weatherCondition = 'drizzling';
    } else {
      weatherCondition = 'rainny';
    }
  }
}
